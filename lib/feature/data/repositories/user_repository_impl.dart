import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_collection_path.dart';
import 'package:store_revision/feature/data/models/remote/user_remote_model.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  // final SharedPreferences _prefs;
  // final HiveInterface _hive;
  // final NetworkInfo _networkInfo;
  UserRepositoryImpl(
    this._firestore,
    this._firebaseAuth,
    // this._prefs,
    // this._hive,
    // this._networkInfo,
  );

  //  Получить всех пользователей
  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      User? userCred = _firebaseAuth.currentUser;
      // final user =
      //     await _firestore.collection(FirestoreCollectionPath.users).get();
      // List<UserRemoteModel> lisrUsers = [];
      // for (var i = 0; i < user.docs.length; i++) {
      //   lisrUsers.add(UserRemoteModel.fromJson(user.docs[i].data()));
      // }
      //  получить всех пользователей
      // final document =
      //     await _firestore.collection(FirestoreCollectionPath.users).get();
      // final allData = document.docs.map((doc) => doc.data()).toList();
      final user =
          await _firestore.collection(FirestoreCollectionPath.users).get();
      final lisrUsers =
          user.docs.map((doc) => UserRemoteModel.fromJson(doc.data())).toList();

      final documentSnapshot = await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(userCred?.uid)
          .get();

      return Right(lisrUsers);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  Добавить ид ревизии из списка у пользователя
  @override
  Future<Either<Failure, void>> addRevisionUser(
      {required String uid, required String revisionId}) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(uid)
          .get();
      List revisions = (snap.data()! as dynamic)['revisions'];

      if (!revisions.contains(revisionId)) {
        await _firestore
            .collection(FirestoreCollectionPath.users)
            .doc(uid)
            .update({
          'revisions': FieldValue.arrayUnion([revisionId])
        });
      }
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  Удалить ид ревизии из списка у пользователя
  @override
  Future<Either<Failure, void>> deleteRevisionUser(
      {required String uid, required String revisionId}) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(uid)
          .get();
      List revisions = (snap.data()! as dynamic)['revisions'];

      if (revisions.contains(revisionId)) {
        await _firestore
            .collection(FirestoreCollectionPath.users)
            .doc(uid)
            .update({
          'revisions': FieldValue.arrayRemove([revisionId])
        });
      }
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
