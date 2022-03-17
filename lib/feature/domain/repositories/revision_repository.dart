import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

abstract class RevisionRepository {
  Future<Either<Failure, RevisionEntity>> createRevision({
    required String uid,
    required String name,
    required String description,
  });

  Future<Either<Failure, void>> editRevision({
    required String id,
    required String name,
    required String description,
  });

  Future<Either<Failure, void>> daleteRevision(String revisionId);

  Future<Either<Failure, void>> openCloseRevision(String revisionId);

  Future<Either<Failure, List<RevisionEntity>>> getRevisions();

  Future<Either<Failure, List<String>>> addTrustedRevision(
      {required String revisionId, required List<String> trustedsId});

  Future<Either<Failure, List<String>>> deleteTrustedRevision(
      {required String revisionId, required List<String> trustedsId});

  Future<Either<Failure, void>> addProductRevision(
      {required String revisionId, required ProductEntity product});

  Future<Either<Failure, void>> deleteProductRevision(
      {required String revisionId, required ProductEntity product});
}
