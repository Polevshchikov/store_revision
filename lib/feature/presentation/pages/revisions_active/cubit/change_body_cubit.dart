import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'change_body_state.dart';

@injectable
class ChangeBodyCubit extends Cubit<ChangeBodyState> {
  ChangeBodyCubit() : super(ShowActiveRevisionState());

  void changeToActiveRevision() => emit(ShowActiveRevisionState());
  void changeToAddTrusted() => emit(ShowTrustedAddState());
  void changeToEditRevision() => emit(ShowEditRevisionState());
}
