import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/trusted_changed_params.dart';

@injectable
class TrustedDeleteUseCase
    extends UseCase<List<UserEntity>, TrustedChangedParams> {
  final RevisionRepository _revisionRepository;
  final UserRepository _userRepository;

  TrustedDeleteUseCase(this._revisionRepository, this._userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(
      TrustedChangedParams params) async {
    final resultTrusteds = await _revisionRepository.deleteTrustedRevision(
        revisionId: params.revisionId, trustedsId: params.trustedsId);

    return resultTrusteds.fold((failure) => Left(failure), (trusteds) async {
      final resultUsers = await _userRepository.getAllUsers();

      return resultUsers.fold((failure) => Left(failure), (users) async {
        final listUsers =
            users.where((e1) => !trusteds.every((e2) => e1.uid != e2)).toList();
        return Right(listUsers);
      });
    });
  }
}
