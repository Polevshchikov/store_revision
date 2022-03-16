import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'change_body_state.dart';

@injectable
class ChangeBodyCubit extends Cubit<ChangeBodyState> {
  ChangeBodyCubit() : super(ChangeBodyState.showActiveRevision());

  void changeToActiveRevision() => emit(ChangeBodyState.showActiveRevision());
  void changeToAddTrusted(String revisionId) =>
      emit(ChangeBodyState.showTrustedAdd(revisionId));
  void changeToDeleteTrusted(String revisionId) =>
      emit(ChangeBodyState.showTrustedDelete(revisionId));
  void changeToEditRevision({
    required String revisionId,
    required String revisionName,
    required String revisionDescr,
  }) =>
      emit(ChangeBodyState.showEditRevision(
          revisionId: revisionId,
          revisionName: revisionName,
          revisionDescr: revisionDescr));
}
