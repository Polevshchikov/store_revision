import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/edit_revision_params.dart';

@injectable
class EditRevisionUseCase extends UseCase<void, EditRevisionParams> {
  final RevisionRepository _revisionRepository;

  EditRevisionUseCase(this._revisionRepository);

  @override
  Future<Either<Failure, void>> call(EditRevisionParams params) async {
    final result = await _revisionRepository.editRevision(
        id: params.id, name: params.name, description: params.description);

    return result.fold((failure) => Left(failure), (_) => Right(_));
  }
}
