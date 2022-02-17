import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class GetRevisionsUseCase extends UseCase<List<RevisionEntity>, NoParams> {
  final RevisionRepository _revisionRepository;

  GetRevisionsUseCase(this._revisionRepository);

  @override
  Future<Either<Failure, List<RevisionEntity>>> call(NoParams params) async {
    return _revisionRepository.getRevisions();
  }
}
