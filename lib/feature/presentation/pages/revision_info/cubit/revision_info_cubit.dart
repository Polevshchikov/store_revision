import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_info_entity.dart';
import 'package:store_revision/feature/domain/usecases/get_info_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/get_info_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'revision_info_state.dart';

@injectable
class RevisionInfoCubit extends Cubit<RevisionInfoState> {
  final GetInfoUseCase _getInfoUseCase;
  RevisionInfoCubit(this._getInfoUseCase) : super(RevisionInfoState.initial());

  Future<void> getInfo(
      {required String revisionId,
      required List<String> listTrustedsId}) async {
    emit(RevisionInfoState.loading());
    final result = await _getInfoUseCase.call(
        GetInfoParams(revisionId: revisionId, trustedsId: listTrustedsId));
    emit(result.fold(
      (failure) => RevisionInfoState.error(failure),
      (revisionInfo) => RevisionInfoState.success(revisionInfo),
    ));
  }
}
