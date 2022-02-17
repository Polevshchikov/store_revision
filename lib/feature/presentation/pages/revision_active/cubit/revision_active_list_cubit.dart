import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/usecases/get_revisions_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'revision_active_list_state.dart';

@injectable
class RevisionActiveListCubit extends Cubit<RevisionActiveListState> {
  final GetRevisionsUseCase _getRevisionsUseCase;
  RevisionActiveListCubit(this._getRevisionsUseCase)
      : super(RevisionActiveListState.initial());

  Future<void> getRevisions() async {
    emit(RevisionActiveListState.loading());
    final result = await _getRevisionsUseCase.call(NoParams());
    emit(result.fold(
      (failure) => RevisionActiveListState.error(failure),
      (listRevision) => RevisionActiveListState.success(listRevision),
    ));
  }
}
