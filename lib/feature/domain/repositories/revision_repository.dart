import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

abstract class RevisionRepository {
  Future<Either<Failure, RevisionEntity>> createRevision({
    required String uid,
    required String name,
    required String description,
    required String username,
  });

  Future<Either<Failure, void>> changeRevision();

  Future<Either<Failure, void>> daleteRevision(String revisionId);
}
