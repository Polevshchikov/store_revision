import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/authentication_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class GetVerificationUseCase extends UseCase<bool, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  GetVerificationUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _authenticationRepository.isVerificationEmail();
  }
}
