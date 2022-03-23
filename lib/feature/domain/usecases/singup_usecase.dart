import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';

import 'params/singup_params.dart';

@injectable
class SignupUseCase extends UseCase<UserEntity, SignUpParams> {
  final AuthenticationRepository _authenticationRepository;

  SignupUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    final result = await _authenticationRepository.signUp(
      email: params.email,
      password: params.password,
      username: params.username,
      photo: params.photo,
    );

    return result.fold((failure) => Left(failure), (user) => Right(user));
  }
}
