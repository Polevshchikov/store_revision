import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/usecases/delete_product_usecase.dart';
import 'package:store_revision/feature/domain/usecases/get_products_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/delete_product_params.dart';
import 'package:store_revision/feature/domain/usecases/params/get_products_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'revision_state.dart';

@injectable
class RevisionCubit extends Cubit<RevisionState> {
  final GetProductsUseCase _getProductsUseCase;
  final DeleteProductsUseCase _deleteProductsUseCase;
  RevisionCubit(this._getProductsUseCase, this._deleteProductsUseCase)
      : super(RevisionState.initial());

  Future<void> getProducts({required String revisionId}) async {
    emit(RevisionState.loading());
    final result = await _getProductsUseCase
        .call(GetProductsParams(revisionId: revisionId));
    emit(result.fold(
      (failure) => RevisionState.error(failure),
      (listProducts) => RevisionState.success(listProducts),
    ));
  }

  Future<void> deleteProducts(
      {required String revisionId, required String productId}) async {
    emit(RevisionState.loading());
    final result = await _deleteProductsUseCase.call(
        DeleteProductParams(revisionId: revisionId, productId: productId));
    emit(result.fold(
      (failure) => RevisionState.error(failure),
      (listProducts) => RevisionState.success(listProducts),
    ));
  }
}
