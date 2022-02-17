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
  final FirebaseFirestore _firestore;
  RevisionRepositoryImpl(
    this._firestore,
  );

  //  To change the data revision
  @override
  Future<Either<Failure, void>> editRevision() {
    throw UnimplementedError();
  }

  //  Create revision firebase database
  @override
  Future<Either<Failure, RevisionEntity>> createRevision({
    required String uid,
    required String name,
    required String description,
  }) async {
    try {
      String revisionId = const Uuid().v1(); // creates unique id based on time,
      final RevisionRemoteModel revision = RevisionRemoteModel(
        id: revisionId,
        name: name,
        description: description,
        listTrusted: const [],
        date: DateTime.now(),
        isClosed: false,
        total: 0,
        uid: uid,
      );

      await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .set(revision.toJson());

      return Right(revision);
    } catch (_) {
      return const Left(UnknownFailure());
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
      return const Right(null);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  //  Get list revision
  @override
  Future<Either<Failure, List<RevisionEntity>>> getRevisions() async {
    try {
      //  получить всех пользователей
      final document =
          await _firestore.collection(FirestoreCollectionPath.revisions).get();
      final allData = document.docs.map((doc) => doc.data()).toList();

      final listRevisions = allData
          .map((revision) => RevisionRemoteModel.fromJson(revision))
          .toList();
      return Right(listRevisions);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
