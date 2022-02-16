import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/delete_revision_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteRevisionUseCase extends UseCase<void, DeleteRevisionParams> {
  final RevisionRepository _revisionRepository;

  DeleteRevisionUseCase(this._revisionRepository);

  @override
  Future<Either<Failure, void>> call(DeleteRevisionParams params) async {
    return _revisionRepository.daleteRevision(params.revisionId);
  }
}
