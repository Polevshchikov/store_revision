import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'revision_active_list_state.dart';

class RevisionActiveListCubit extends Cubit<RevisionActiveListState> {
  RevisionActiveListCubit() : super(RevisionActiveListState.initial());
}
