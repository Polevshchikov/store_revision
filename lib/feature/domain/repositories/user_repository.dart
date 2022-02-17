import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> addRevisionUser(
      {required String uid, required String revisionId});

  Future<Either<Failure, void>> deleteRevisionUser(
      {required String uid, required String revisionId});

  Future<Either<Failure, List<UserEntity>>> getAllUsers();
}
