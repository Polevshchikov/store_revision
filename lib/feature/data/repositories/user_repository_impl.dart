import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_%20collection_path.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  // final SharedPreferences _prefs;
  // final HiveInterface _hive;
  // final NetworkInfo _networkInfo;
  UserRepositoryImpl(
    this._firestore,
    // this._prefs,
    // this._hive,
    // this._networkInfo,
  );

  @override
  Future<Either<Failure, void>> changeRevisionUser(
      {required String uid, required String revisionId}) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.users)
          .doc(uid)
          .get();
      List revisions =
          (snap.data()! as dynamic)[FirestoreCollectionPath.revisions];

      if (revisions.contains(revisionId)) {
        await _firestore
            .collection(FirestoreCollectionPath.users)
            .doc(uid)
            .update({
          FirestoreCollectionPath.revisions:
              FieldValue.arrayRemove([revisionId])
        });
      } else {
        await _firestore
            .collection(FirestoreCollectionPath.users)
            .doc(uid)
            .update({
          FirestoreCollectionPath.revisions: FieldValue.arrayUnion([revisionId])
        });
      }
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
