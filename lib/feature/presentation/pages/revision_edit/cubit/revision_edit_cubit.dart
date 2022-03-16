import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'revision_edit_state.dart';

class RevisionEditCubit extends Cubit<RevisionEditState> {
  RevisionEditCubit() : super(RevisionEditInitial());
}
