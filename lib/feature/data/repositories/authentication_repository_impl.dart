import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_collection_path.dart';
import 'package:store_revision/feature/data/models/local/product_local_model.dart';
import 'package:store_revision/feature/data/models/local/products_cache_local_model.dart';
import 'package:store_revision/feature/data/models/local/revision_local_model.dart';
import 'package:store_revision/feature/data/models/local/revisions_cache_local_model.dart';
import 'package:store_revision/feature/data/models/local/user_local_model.dart';
import 'package:store_revision/feature/data/models/local/users_cache_local_model.dart';
import 'package:store_revision/feature/data/models/remote/user_remote_model.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  static const _userKey = 'user_key';

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final SharedPreferences _prefs;
  final HiveInterface _hive;
  final Connectivity _connectivity;
  AuthenticationRepositoryImpl(
    this._firebaseAuth,
    this._firestore,
    this._hive,
    this._connectivity,
    this._prefs,
  );

  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<Either<Failure, void>> logOut() async {
    final userBox = await _hive.openBox<UserLocalModel>(userBoxKey);
    final usersBox =
        await _hive.openBox<UsersCacheLocalModel>(usersCacheBoxKey);
    final revisionsBox =
        await _hive.openBox<RevisionsCacheLocalModel>(revisionsCacheBoxKey);
    final revisionBox = await _hive.openBox<RevisionLocalModel>(revisionBoxKey);
    final productBox = await _hive.openBox<ProductLocalModel>(productBoxKey);
    final productsBox =
        await _hive.openBox<ProductsCacheLocalModel>(productsCacheBoxKey);
    try {
      await userBox.clear();
      await usersBox.clear();
      await revisionsBox.clear();
      await revisionBox.clear();
      await productBox.clear();
      await productsBox.clear();
      await _prefs.clear();
      await _hive.deleteFromDisk();
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (_) {
      return const Left(LogOutFailure());
    } finally {
      await userBox.close();
      await usersBox.close();
      await revisionsBox.close();
      await revisionBox.close();
      await productBox.close();
      await productsBox.close();
    }
  }

  @override
  Future<Either<Failure, void>> fetchPasswordRecovery(username) async {
    print('Password Recovery');
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    print('Change Password');
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity>> getAuthenticatedUser() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    try {
      final key = _prefs.getString(_userKey);

      final userBox = await _hive.openBox<UserLocalModel>(userBoxKey);

      if (connectivityResult != ConnectivityResult.wifi &&
          connectivityResult != ConnectivityResult.mobile) {
        final cachedUser = userBox.get(key);
        if (cachedUser != null) {
          return Right(cachedUser);
        }
      }

      User? userCred = _firebaseAuth.currentUser;
      await userCred?.reload();
      // Get docs from collection reference
      final documentSnapshot = await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(userCred?.uid)
          .get();

      final UserRemoteModel user =
          UserRemoteModel.fromJson(documentSnapshot.data()!);

      await userBox.put(key, UserLocalModel.from(user));
      await userBox.close();

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(LogInWithEmailAndPasswordFailure(e.code));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendVerificationEmail() async {
    try {
      User? userCred = _firebaseAuth.currentUser;
      await userCred?.sendEmailVerification();

      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isVerificationEmail() async {
    try {
      User? userCred = _firebaseAuth.currentUser;
      await userCred?.reload();
      final isVerification = userCred?.emailVerified ?? false;
      return Right(isVerification);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  авторизация пользователя
  @override
  Future<Either<Failure, UserEntity>> logIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get docs from collection reference
      final documentSnapshot = await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(userCred.user?.uid)
          .get();
      if (userCred.user != null) {
        await _prefs.setString(_userKey, userCred.user!.uid);
      }

      final UserRemoteModel user =
          UserRemoteModel.fromJson(documentSnapshot.data()!);

      final userBox = await _hive.openBox<UserLocalModel>(userBoxKey);
      await userBox.put(userCred.user?.uid, UserLocalModel.from(user));
      await userBox.close();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(LogInWithEmailAndPasswordFailure(e.code));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  //  регистрация пользователя
  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String username,
    // String? photo,
  }) async {
    try {
      //  регистрация пользователя в firebase
      UserCredential userCred =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.updateDisplayName(username);
      //await user?.updatePhotoURL(photo);
      final UserRemoteModel user = UserRemoteModel(
        uid: userCred.user!.uid,
        email: email,
        name: username,
        photo: '',
        revisions: const [],
      );

      if (userCred.user != null) {
        await _prefs.setString(_userKey, userCred.user!.uid);
      }
      //  добавить пользователя в базу данных
      await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(userCred.user?.uid)
          .set(user.toJson());

      final userBox = await _hive.openBox<UserLocalModel>(userBoxKey);
      await userBox.put(userCred.user?.uid, UserLocalModel.from(user));
      await userBox.close();

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(SignUpWithEmailAndPasswordFailure(e.code));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
