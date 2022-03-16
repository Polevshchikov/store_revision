import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class GetAuthenticatedUserUseCase extends UseCase<UserEntity, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  GetAuthenticatedUserUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    final result = await _authenticationRepository.getAuthenticatedUser();

    return result.fold((failure) => Left(failure), (user) => Right(user));
  }
}
