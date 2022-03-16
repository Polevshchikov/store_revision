import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogoutUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final result = await _authenticationRepository.logOut();

    return result.fold((failure) => Left(failure), (user) => Right(user));
  }
}
