import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_collection_path.dart';
import 'package:store_revision/feature/data/models/local/users_cache_local_model.dart';
import 'package:store_revision/feature/data/models/remote/user_remote_model.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final HiveInterface _hive;
  final Connectivity _connectivity;
  UserRepositoryImpl(
    this._firestore,
    this._firebaseAuth,
    this._hive,
    this._connectivity,
  );

  //  Получить всех пользователей
  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    const key = 'allUsers';

    final connectivityResult = await _connectivity.checkConnectivity();
    try {
      final usersBox =
          await _hive.openBox<UsersCacheLocalModel>(usersCacheBoxKey);

      if (connectivityResult != ConnectivityResult.wifi &&
          connectivityResult != ConnectivityResult.mobile) {
        final cachedUsers = usersBox.get(key);
        if (cachedUsers != null) {
          if (DateTime.now().isBefore(DateTime.parse(cachedUsers.createdAt)
              .add(const Duration(hours: 1)))) {
            return Right(cachedUsers.users);
          }
        }
      }
      User? userCred = _firebaseAuth.currentUser;

      final user =
          await _firestore.collection(FirestoreCollectionPath.users).get();
      final lisrUsers =
          user.docs.map((doc) => UserRemoteModel.fromJson(doc.data())).toList();
      lisrUsers.removeWhere((item) => item.uid == userCred?.uid);
      await usersBox.put(key, UsersCacheLocalModel.from(lisrUsers));
      await usersBox.close();

      return Right(lisrUsers);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  Добавить ид ревизии в список пользователя
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
