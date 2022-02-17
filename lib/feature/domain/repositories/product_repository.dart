import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> createProduct({
    required String uid,
    required String revisionId,
    required String name,
    required String userName,
    required double cost,
    required double count,
  });

  Future<Either<Failure, void>> editProduct();

  Future<Either<Failure, void>> daleteProduct({
    required String revisionId,
    required String productId,
  });
}
