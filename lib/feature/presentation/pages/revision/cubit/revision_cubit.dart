import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'revision_state.dart';

class RevisionCubit extends Cubit<RevisionState> {
  RevisionCubit() : super(RevisionInitial());
}
