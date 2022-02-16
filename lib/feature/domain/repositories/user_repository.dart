import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> changeRevisionUser(
      {required String uid, required String revisionId});
}
