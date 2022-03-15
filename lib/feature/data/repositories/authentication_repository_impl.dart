import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_collection_path.dart';
import 'package:store_revision/feature/data/models/remote/user_remote_model.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  // final SharedPreferences _prefs;
  // final HiveInterface _hive;
  // final NetworkInfo _networkInfo;
  AuthenticationRepositoryImpl(
    this._firebaseAuth,
    this._firestore,
    // this._prefs,
    // this._hive,
    // this._networkInfo,
  );

  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<Either<Failure, void>> logOut() async {
//  await Future.wait([
//         _firebaseAuth.signOut(),
//         _googleSignIn.signOut(),
//       ]);
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (_) {
      return const Left(LogOutFailure());
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
    try {
      User? userCred = _firebaseAuth.currentUser;
      await userCred?.reload();
      // Get docs from collection reference
      final documentSnapshot = await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(userCred?.uid)
          .get();

      final UserRemoteModel user =
          UserRemoteModel.fromJson(documentSnapshot.data()!);
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

      final UserRemoteModel user =
          UserRemoteModel.fromJson(documentSnapshot.data()!);

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
      //  добавить пользователя в базу данных
      await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(userCred.user?.uid)
          .set(user.toJson());
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(SignUpWithEmailAndPasswordFailure(e.code));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
