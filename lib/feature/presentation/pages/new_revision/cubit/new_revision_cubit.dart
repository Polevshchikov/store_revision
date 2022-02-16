import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/usecases/create_revision_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/create_revision_params.dart';
import 'package:store_revision/feature/presentation/pages/new_revision/components/revision_descr.dart';
import 'package:store_revision/feature/presentation/pages/new_revision/components/revision_name.dart';

part 'new_revision_state.dart';

@injectable
class NewRevisionCubit extends Cubit<NewRevisionState> {
  final CreateRevisionUseCase _createRevisionUseCase;
  NewRevisionCubit(this._createRevisionUseCase)
      : super(const NewRevisionState());

  void revisionNameChanged(String value) {
    final name = RevisionName.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name]),
    ));
  }

  void revisionDescrChanged(String value) {
    final descr = RevisionDescr.dirty(value);
    emit(state.copyWith(
      description: descr,
      status: Formz.validate([descr]),
    ));
  }

  Future<void> createRevision(
      {required String uid, required String username}) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final result = await _createRevisionUseCase.call(CreateRevisionParams(
      uid: uid,
      username: username,
      name: state.name.value,
      description: state.description.value,
    ));
    await result.fold((failure) async {
      emit(state.copyWith(
        failure: failure,
        status: FormzStatus.submissionFailure,
      ));
    }, (user) async {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
