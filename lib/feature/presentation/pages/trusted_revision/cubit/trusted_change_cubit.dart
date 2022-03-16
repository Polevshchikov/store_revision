import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/usecases/add_trusted_usecase.dart';
import 'package:store_revision/feature/domain/usecases/delete_trusted_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/trusted_changed_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:injectable/injectable.dart';

part 'trusted_change_state.dart';

@injectable
class TrustedChangeCubit extends Cubit<TrustedChangeState> {
  final TrustedAddUseCase _trustedAddUseCase;
  final TrustedDeleteUseCase _trustedDeleteUseCase;
  TrustedChangeCubit(this._trustedAddUseCase, this._trustedDeleteUseCase)
      : super(TrustedChangeState.initial());

  Future<void> addTrusted({
    required List<String> trustedsId,
    required String revisionId,
  }) async {
    emit(TrustedChangeState.loading());
    final result = await _trustedAddUseCase.call(
        TrustedChangedParams(trustedsId: trustedsId, revisionId: revisionId));
    emit(result.fold(
      (failure) => TrustedChangeState.error(failure),
      (users) => TrustedChangeState.success(users),
    ));
  }

  Future<void> deleteTrusted({
    required List<String> trustedsId,
    required String revisionId,
  }) async {
    emit(TrustedChangeState.loading());
    final result = await _trustedDeleteUseCase.call(
        TrustedChangedParams(trustedsId: trustedsId, revisionId: revisionId));
    emit(result.fold(
      (failure) => TrustedChangeState.error(failure),
      (users) => TrustedChangeState.success(users),
    ));
  }
}
