import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/exception.dart';
import 'package:store_revision/core/error/failure.dart';
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

  // /// Stream of [User] which will emit the current user when
  // /// the authentication state changes.
  // ///
  // /// Emits [User.empty] if the user is not authenticated.
  // Stream<User> get user {
  //   return _firebaseAuth.authStateChanges().map((firebaseUser) {
  //     final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
  //     // _cache.write(key: userCacheKey, value: user);
  //     return user;
  //   });
  // }

  // /// Returns the current cached user.
  // /// Defaults to [User.empty] if there is no cached user.
  // User get currentUser {
  //   return _cache.read<User>(key: userCacheKey) ?? User.empty;
  // }

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
      throw LogOutFailure();
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
      final documentSnapshot =
          await _firestore.collection('users').doc(userCred.user!.uid).get();

      final UserRemoteModel user =
          UserRemoteModel.fromJson(documentSnapshot.data()!);

      return Right(user);
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
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
      final UserRemoteModel user = UserRemoteModel(
          uid: userCred.user!.uid, email: email, name: username, photo: '');
      //  добавить пользователя в базу данных
      await _firestore
          .collection('users')
          .doc(userCred.user!.uid)
          .set(user.toJson());
      return Right(user);
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<Either<Failure, void>> logInWithGoogle() async {
    print('logInWithGoogle');
    return const Right(null);
    // try {
    //   late final firebase_auth.AuthCredential credential;
    //   if (isWeb) {
    //     final googleProvider = firebase_auth.GoogleAuthProvider();
    //     final userCredential = await _firebaseAuth.signInWithPopup(
    //       googleProvider,
    //     );
    //     credential = userCredential.credential!;
    //   } else {
    //     final googleUser = await _googleSignIn.signIn();
    //     final googleAuth = await googleUser!.authentication;
    //     credential = firebase_auth.GoogleAuthProvider.credential(
    //       accessToken: googleAuth.accessToken,
    //       idToken: googleAuth.idToken,
    //     );
    //   }
    // }
  }
}

// /// {@template authentication_repository}
// /// Repository which manages user authentication.
// /// {@endtemplate}
// class AuthenticationRepository {
//   /// {@macro authentication_repository}
//   AuthenticationRepository({
//     CacheClient? cache,
//     firebase_auth.FirebaseAuth? firebaseAuth,
//     GoogleSignIn? googleSignIn,
//   })  : _cache = cache ?? CacheClient(),
//         _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
//         _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

//   final CacheClient _cache;
//   final firebase_auth.FirebaseAuth _firebaseAuth;
//   final GoogleSignIn _googleSignIn;

//   /// Whether or not the current environment is web
//   /// Should only be overriden for testing purposes. Otherwise,
//   /// defaults to [kIsWeb]
//   @visibleForTesting
//   bool isWeb = kIsWeb;

//   /// User cache key.
//   /// Should only be used for testing purposes.
//   @visibleForTesting
//   static const userCacheKey = '__user_cache_key__';

//   /// Stream of [User] which will emit the current user when
//   /// the authentication state changes.
//   ///
//   /// Emits [User.empty] if the user is not authenticated.
//   Stream<User> get user {
//     return _firebaseAuth.authStateChanges().map((firebaseUser) {
//       final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
//       _cache.write(key: userCacheKey, value: user);
//       return user;
//     });
//   }

//   /// Returns the current cached user.
//   /// Defaults to [User.empty] if there is no cached user.
//   User get currentUser {
//     return _cache.read<User>(key: userCacheKey) ?? User.empty;
//   }

//   /// Creates a new user with the provided [email] and [password].
//   ///
//   /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
//   Future<void> signUp({required String email, required String password}) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
//     } catch (_) {
//       throw const SignUpWithEmailAndPasswordFailure();
//     }
//   }

//   /// Starts the Sign In with Google Flow.
//   ///
//   /// Throws a [LogInWithGoogleFailure] if an exception occurs.
//   Future<void> logInWithGoogle() async {
//     try {
//       late final firebase_auth.AuthCredential credential;
//       if (isWeb) {
//         final googleProvider = firebase_auth.GoogleAuthProvider();
//         final userCredential = await _firebaseAuth.signInWithPopup(
//           googleProvider,
//         );
//         credential = userCredential.credential!;
//       } else {
//         final googleUser = await _googleSignIn.signIn();
//         final googleAuth = await googleUser!.authentication;
//         credential = firebase_auth.GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//       }

//       await _firebaseAuth.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       throw LogInWithGoogleFailure.fromCode(e.code);
//     } catch (_) {
//       throw const LogInWithGoogleFailure();
//     }
//   }


//   /// Signs out the current user which will emit
//   /// [User.empty] from the [user] Stream.
//   ///
//   /// Throws a [LogOutFailure] if an exception occurs.
//   Future<void> logOut() async {
//     try {
//       await Future.wait([
//         _firebaseAuth.signOut(),
//         _googleSignIn.signOut(),
//       ]);
//     } catch (_) {
//       throw LogOutFailure();
//     }
//   }
// }

// extension on firebase_auth.User {
//   User get toUser {
//     return User(id: uid, email: email, name: displayName, photo: photoURL);
//   }
// }
