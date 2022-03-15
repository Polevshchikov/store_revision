import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserEntity>> logIn(
      {required String email, required String password});

  Future<Either<Failure, void>> logOut();

  Future<Either<Failure, UserEntity>> getAuthenticatedUser();

  Future<Either<Failure, bool>> isVerificationEmail();

  Future<Either<Failure, void>> sendVerificationEmail();

  Future<Either<Failure, void>> fetchPasswordRecovery(String email);

  Future<Either<Failure, void>> changePassword(
      {required String oldPassword, required String newPassword});

  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String username,
    // String? photo,
  });
}
