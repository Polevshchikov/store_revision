import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/usecases/add_trusted_usecase.dart';
import 'package:store_revision/feature/domain/usecases/delete_trusted_usecase.dart';
import 'package:store_revision/feature/domain/usecases/get_users_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';
import 'package:store_revision/feature/domain/usecases/params/trusted_changed_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:injectable/injectable.dart';

part 'trusted_add_state.dart';

@injectable
class TrustedAddCubit extends Cubit<TrustedAddState> {
  final GetUsersUseCase _getUsersUseCase;
  final TrustedAddUseCase _trustedAddUseCase;
  final TrustedDeleteUseCase _trustedDeleteUseCase;
  TrustedAddCubit(this._getUsersUseCase, this._trustedAddUseCase,
      this._trustedDeleteUseCase)
      : super(TrustedAddState.initial());

  Future<void> getUsers() async {
    emit(TrustedAddState.loading());
    final result = await _getUsersUseCase.call(NoParams());
    emit(result.fold(
      (failure) => TrustedAddState.error(failure),
      (users) => TrustedAddState.success(users),
    ));
  }

  Future<void> addTrusted({
    required List<String> trustedsId,
    required String revisionId,
  }) async {
    emit(TrustedAddState.loading());
    final result = await _trustedAddUseCase.call(
        TrustedChangedParams(trustedsId: trustedsId, revisionId: revisionId));
    emit(result.fold(
      (failure) => TrustedAddState.error(failure),
      (users) => TrustedAddState.success(users),
    ));
  }

  Future<void> deleteTrusted({
    required List<String> trustedsId,
    required String revisionId,
  }) async {
    emit(TrustedAddState.loading());
    final result = await _trustedDeleteUseCase.call(
        TrustedChangedParams(trustedsId: trustedsId, revisionId: revisionId));
    emit(result.fold(
      (failure) => TrustedAddState.error(failure),
      (users) => TrustedAddState.success(users),
    ));
  }
}
