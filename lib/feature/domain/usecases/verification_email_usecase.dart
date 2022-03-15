import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class VerificationEmailUseCase extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  VerificationEmailUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authenticationRepository.sendVerificationEmail();
  }
}
