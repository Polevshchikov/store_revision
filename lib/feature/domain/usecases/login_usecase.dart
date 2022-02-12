import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/login_params.dart';

@injectable
class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return _authenticationRepository.logIn(
        email: params.email, password: params.password);
  }
}
