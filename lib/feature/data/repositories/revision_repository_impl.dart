import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_collection_path.dart';
import 'package:store_revision/feature/data/models/local/revisions_cache_local_model.dart';
import 'package:store_revision/feature/data/models/remote/revision_remote_model.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:uuid/uuid.dart';

@Injectable(as: RevisionRepository)
class RevisionRepositoryImpl implements RevisionRepository {
  final FirebaseFirestore _firestore;
  final HiveInterface _hive;
  final Connectivity _connectivity;
  RevisionRepositoryImpl(
    this._firestore,
    this._hive,
    this._connectivity,
  );

  //  To change the data revision
  @override
  Future<Either<Failure, void>> editRevision({
    required String id,
    required String name,
    required String description,
  }) async {
    try {
      if (name.isNotEmpty) {
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(id)
            .update({'name': name});
      }
      if (description.isNotEmpty) {
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(id)
            .update({'description': description});
      }

      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
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
        listProducts: const [],
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
    const key = 'allRevision';

    final connectivityResult = await _connectivity.checkConnectivity();
    try {
      final revisionsBox =
          await _hive.openBox<RevisionsCacheLocalModel>(revisionsCacheBoxKey);

      if (connectivityResult != ConnectivityResult.wifi &&
          connectivityResult != ConnectivityResult.mobile) {
        final cachedRevisions = revisionsBox.get(key);
        if (cachedRevisions != null) {
          if (DateTime.now().isBefore(DateTime.parse(cachedRevisions.createdAt)
              .add(const Duration(hours: 1)))) {
            return Right(cachedRevisions.revisions);
          }
        }
      }
      //  получить все ревизии
      final document =
          await _firestore.collection(FirestoreCollectionPath.revisions).get();
      final allData = document.docs.map((doc) => doc.data()).toList();

      final listRevisions = allData
          .map((revision) => RevisionRemoteModel.fromJson(revision))
          .toList();

      await revisionsBox.put(key, RevisionsCacheLocalModel.from(listRevisions));
      await revisionsBox.close();

      return Right(listRevisions);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  //  Add trusted id to revision list
  @override
  Future<Either<Failure, List<String>>> addTrustedRevision(
      {required String revisionId, required List<String> trustedsId}) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .get();
      List<dynamic> listTrusted = (snap.data()! as dynamic)['listTrusted'];
      final trusteds = listTrusted.map((e) => e.toString()).toList();
      for (var id in trustedsId) {
        if (!listTrusted.contains(id)) {
          await _firestore
              .collection(FirestoreCollectionPath.revisions)
              .doc(revisionId)
              .update({
            'listTrusted': FieldValue.arrayUnion([id])
          });
          trusteds.add(id);
        }
      }

      return Right(trusteds);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  Remove trusted from revision list
  @override
  Future<Either<Failure, List<String>>> deleteTrustedRevision(
      {required String revisionId, required List<String> trustedsId}) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .get();
      List<dynamic> listTrusted = (snap.data()! as dynamic)['listTrusted'];
      final trusteds = listTrusted.map((e) => e.toString()).toList();
      for (var id in trustedsId) {
        if (listTrusted.contains(id)) {
          await _firestore
              .collection(FirestoreCollectionPath.revisions)
              .doc(revisionId)
              .update({
            'listTrusted': FieldValue.arrayRemove([id])
          });
        }
        trusteds.removeWhere((element) => element == id);
      }

      return Right(trusteds);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  Add item id to revision list
  @override
  Future<Either<Failure, void>> addProductRevision(
      {required String revisionId, required ProductEntity product}) async {
    final productId = product.id;
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .get();
      List products = (snap.data()! as dynamic)['listProducts'];

      if (!products.contains(productId)) {
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(revisionId)
            .update({
          'listProducts': FieldValue.arrayUnion([productId])
        });
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(revisionId)
            .update({'total': FieldValue.increment(product.total)});
      }
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  Remove item from revision list
  @override
  Future<Either<Failure, void>> deleteProductRevision(
      {required String revisionId, required ProductEntity product}) async {
    final productId = product.id;
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .get();
      List products = (snap.data()! as dynamic)['listProducts'];

      if (products.contains(productId)) {
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(revisionId)
            .update({
          'listProducts': FieldValue.arrayRemove([productId])
        });
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(revisionId)
            .update({'total': FieldValue.increment(-product.total)});
      }
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  //  Open - Сlose revision
  @override
  Future<Either<Failure, void>> openCloseRevision(String revisionId) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .get();

      final bool isClosed = (snap.data()! as dynamic)['isClosed'];

      if (isClosed == false) {
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(revisionId)
            .update({'isClosed': true});
      } else {
        await _firestore
            .collection(FirestoreCollectionPath.revisions)
            .doc(revisionId)
            .update({'isClosed': false});
      }
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
