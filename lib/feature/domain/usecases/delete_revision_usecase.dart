import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/delete_revision_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteRevisionUseCase
    extends UseCase<List<RevisionEntity>, DeleteRevisionParams> {
  final RevisionRepository _revisionRepository;
  final UserRepository _userRepository;

  DeleteRevisionUseCase(this._revisionRepository, this._userRepository);

  @override
  Future<Either<Failure, List<RevisionEntity>>> call(
      DeleteRevisionParams params) async {
    final resultRevision =
        await _revisionRepository.daleteRevision(params.revisionId);

    return resultRevision.fold((failure) => Left(failure), (revision) async {
      final resultUser = await _userRepository.deleteRevisionUser(
          uid: params.userId, revisionId: params.revisionId);

      return resultUser.fold((failure) => Left(failure), (result) async {
        final result = await _revisionRepository.getRevisions();
        return result.fold(
            (failure) => Left(failure), (revisions) => Right(revisions));
      });
    });
  }
}
