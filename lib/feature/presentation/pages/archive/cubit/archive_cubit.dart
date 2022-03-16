import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/usecases/get_revisions_usecase.dart';
import 'package:store_revision/feature/domain/usecases/open_close_revision_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';
import 'package:store_revision/feature/domain/usecases/params/open_close_revision_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'archive_state.dart';

@injectable
class ArchiveCubit extends Cubit<ArchiveState> {
  final GetRevisionsUseCase _getRevisionsUseCase;
  final OpenCloseRevisionUseCase _openCloseRevisionUseCase;
  ArchiveCubit(this._getRevisionsUseCase, this._openCloseRevisionUseCase)
      : super(ArchiveState.initial());

  Future<void> getRevisions({required String userId}) async {
    emit(ArchiveState.loading());
    final result = await _getRevisionsUseCase.call(NoParams());
    emit(result.fold((failure) => ArchiveState.error(failure), (listRevision) {
      final listFiltered = listRevision
          .where((element) => (element.isClosed == true &&
              (element.uid == userId || element.listTrusted.contains(userId))))
          .toList();
      return ArchiveState.success(listFiltered);
    }));
  }

  Future<void> openRevision(
      {required String revisionId, required String userId}) async {
    final result = await _openCloseRevisionUseCase
        .call(OpenCloseRevisionParams(revisionId: revisionId));
    emit(result.fold((failure) => ArchiveState.error(failure), (listRevision) {
      final listFiltered = listRevision
          .where((element) => (element.isClosed == true &&
              (element.uid == userId || element.listTrusted.contains(userId))))
          .toList();
      return ArchiveState.success(listFiltered);
    }));
  }
}
