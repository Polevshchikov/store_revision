import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_%20collection_path.dart';
import 'package:store_revision/feature/data/models/remote/user_remote_model.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:uuid/uuid.dart';

@Injectable(as: RevisionRepository)
class RevisionRepositoryImpl implements RevisionRepository {
  // final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  // final SharedPreferences _prefs;
  // final HiveInterface _hive;
  // final NetworkInfo _networkInfo;
  RevisionRepositoryImpl(
    // this._firebaseAuth,
    this._firestore,
    // this._prefs,
    // this._hive,
    // this._networkInfo,
  );

  @override
  Future<Either<Failure, void>> changeRevision() {
    throw UnimplementedError();
  }

  //  Create revision firebase database
  @override
  Future<Either<Failure, RevisionEntity>> createRevision({
    required String uid,
    required String name,
    required String description,
    required String username,
  }) async {
    try {
      // String photoUrl =
      //     await StorageMethods().uploadImageToStorage('posts', file, true);
      String revisionId = const Uuid().v1(); // creates unique id based on time,
      final RevisionRemoteModel revision = RevisionRemoteModel(
        id: revisionId,
        name: name,
        description: description,
        listProducts: const [],
        date: DateTime.now(),
        creatorName: username,
        isClosed: false,
        score: 0,
        uid: uid,
      );

      _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .set(revision.toJson());

      return Right(revision);
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  // Delete revision
  @override
  Future<Either<Failure, void>> daleteRevision(String revisionId) async {
    try {
      await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .delete();
      return Right(null);
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
