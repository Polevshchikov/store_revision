import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/usecases/delete_revision_usecase.dart';
import 'package:store_revision/feature/domain/usecases/get_revisions_usecase.dart';
import 'package:store_revision/feature/domain/usecases/open_close_revision_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/delete_revision_params.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';
import 'package:store_revision/feature/domain/usecases/params/open_close_revision_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'revisions_active_list_state.dart';

@injectable
class RevisionActiveListCubit extends Cubit<RevisionActiveListState> {
  final GetRevisionsUseCase _getRevisionsUseCase;
  final DeleteRevisionUseCase _deleteRevisionUseCase;
  final OpenCloseRevisionUseCase _openCloseRevisionUseCase;
  RevisionActiveListCubit(this._getRevisionsUseCase,
      this._deleteRevisionUseCase, this._openCloseRevisionUseCase)
      : super(RevisionActiveListState.initial());

  Future<void> getRevisions() async {
    emit(RevisionActiveListState.loading());
    final result = await _getRevisionsUseCase.call(NoParams());
    emit(result.fold((failure) => RevisionActiveListState.error(failure),
        (listRevision) {
      final listFiltered =
          listRevision.where((element) => element.isClosed == false).toList();
      return RevisionActiveListState.success(listFiltered);
    }));
  }

  Future<void> deleteRevision(
      {required String revisionId, required String userId}) async {
    emit(RevisionActiveListState.loading());
    final result = await _deleteRevisionUseCase.call(DeleteRevisionParams(
      revisionId: revisionId,
      userId: userId,
    ));
    emit(result.fold((failure) => RevisionActiveListState.error(failure),
        (listRevision) {
      final listFiltered =
          listRevision.where((element) => element.isClosed == false).toList();
      return RevisionActiveListState.success(listFiltered);
    }));
  }

  Future<void> closeRevision({required String revisionId}) async {
    final result = await _openCloseRevisionUseCase
        .call(OpenCloseRevisionParams(revisionId: revisionId));
    emit(result.fold((failure) => RevisionActiveListState.error(failure),
        (listRevision) {
      final listFiltered =
          listRevision.where((element) => element.isClosed == false).toList();
      return RevisionActiveListState.success(listFiltered);
    }));
  }
}
