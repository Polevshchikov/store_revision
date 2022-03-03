import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/open_close_revision_params.dart';

@injectable
class OpenCloseRevisionUseCase
    extends UseCase<List<RevisionEntity>, OpenCloseRevisionParams> {
  final RevisionRepository _revisionRepository;

  OpenCloseRevisionUseCase(this._revisionRepository);

  @override
  Future<Either<Failure, List<RevisionEntity>>> call(
      OpenCloseRevisionParams params) async {
    final resultOpenClose =
        await _revisionRepository.openCloseRevision(params.revisionId);

    return resultOpenClose.fold((failure) => Left(failure), (_) async {
      final resultGetRevision = await _revisionRepository.getRevisions();
      return resultGetRevision.fold(
          (failure) => Left(failure), (revisions) => Right(revisions));
    });
  }
}
