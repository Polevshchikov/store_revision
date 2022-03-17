import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/usecases/edit_product_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/edit_product_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

part 'product_edit_state.dart';

@injectable
class ProductEditCubit extends Cubit<ProductEditState> {
  final EditProductUseCase _editProductUseCase;
  ProductEditCubit(this._editProductUseCase)
      : super(ProductEditState.initial());

  Future<void> resetState() async {
    emit(ProductEditState.initial());
  }

  Future<void> editProduct({
    required String revisionId,
    required String productId,
    required String productName,
    required String productCost,
    required String productQuantity,
  }) async {
    emit(ProductEditState.loading());
    final result = await _editProductUseCase.call(EditProductParams(
      revisionId: revisionId,
      productId: productId,
      productName: productName,
      productCost: productCost.isEmpty ? -1 : double.parse(productCost),
      productQuantity:
          productQuantity.isEmpty ? -1 : double.parse(productQuantity),
    ));
    await result.fold((failure) async {
      emit(ProductEditState.error(failure));
    }, (_) async {
      emit(ProductEditState.success());
    });
  }
}
