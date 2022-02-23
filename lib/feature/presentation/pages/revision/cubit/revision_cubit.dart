import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/usecases/get_products_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/get_products_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'revision_state.dart';

@injectable
class RevisionCubit extends Cubit<RevisionState> {
  final GetProductsUseCase _getProductsUseCase;
  RevisionCubit(this._getProductsUseCase) : super(RevisionState.initial());

  Future<void> getProducts({required String revisionId}) async {
    emit(RevisionState.loading());
    final result = await _getProductsUseCase
        .call(GetProductsParams(revisionId: revisionId));
    emit(result.fold(
      (failure) => RevisionState.error(failure),
      (listProducts) => RevisionState.success(listProducts),
    ));
  }
}
