import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

abstract class RevisionRepository {
  Future<Either<Failure, RevisionEntity>> createRevision({
    required String uid,
    required String name,
    required String description,
  });

  Future<Either<Failure, void>> editRevision();

  Future<Either<Failure, void>> daleteRevision(String revisionId);

  Future<Either<Failure, List<RevisionEntity>>> getRevisions();
}
