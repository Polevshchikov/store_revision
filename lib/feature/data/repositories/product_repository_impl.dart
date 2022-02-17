import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/data/components/firestore_%20collection_path.dart';
import 'package:store_revision/feature/data/models/remote/user_remote_model.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';
import 'package:uuid/uuid.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore;
  ProductRepositoryImpl(
    this._firestore,
  );

  //  To change the data product
  @override
  Future<Either<Failure, void>> editProduct() {
    throw UnimplementedError();
  }

  //  Create product firebase database
  @override
  Future<Either<Failure, ProductEntity>> createProduct({
    required String uid,
    required String revisionId,
    required String name,
    required String userName,
    required double cost,
    required double count,
  }) async {
    try {
      String productId = const Uuid().v1(); // creates unique id based on time,
      final ProductRemoteModel product = ProductRemoteModel(
        uid: uid,
        id: productId,
        name: name,
        userName: userName,
        datePublished: DateTime.now(),
        cost: cost,
        count: count,
        total: cost * count,
      );

      _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .collection(FirestoreCollectionPath.products)
          .doc(productId)
          .set(product.toJson());

      return Right(product);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  // Delete product
  @override
  Future<Either<Failure, void>> daleteProduct({
    required String revisionId,
    required String productId,
  }) async {
    try {
      await _firestore
          .collection(FirestoreCollectionPath.revisions)
          .doc(revisionId)
          .collection(FirestoreCollectionPath.products)
          .doc(productId)
          .delete();
      return const Right(null);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
