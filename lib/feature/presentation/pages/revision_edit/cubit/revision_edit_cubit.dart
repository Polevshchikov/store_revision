import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/usecases/edit_revision_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/edit_revision_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'revision_edit_state.dart';

@injectable
class RevisionEditCubit extends Cubit<RevisionEditState> {
  final EditRevisionUseCase _editRevisionUseCase;
  RevisionEditCubit(this._editRevisionUseCase)
      : super(RevisionEditState.initial());

  Future<void> resetState() async {
    emit(RevisionEditState.initial());
  }

  Future<void> editRevision({
    required String revisionId,
    required String revisionName,
    required String revisionDescr,
  }) async {
    emit(RevisionEditState.loading());
    final result = await _editRevisionUseCase.call(EditRevisionParams(
      id: revisionId,
      name: revisionName,
      description: revisionDescr,
    ));
    await result.fold((failure) async {
      emit(RevisionEditState.error(failure));
    }, (_) async {
      emit(RevisionEditState.success());
    });
  }
}
