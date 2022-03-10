import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/usecases/create_product_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/create_product_params.dart';
import 'package:store_revision/feature/presentation/pages/product_add/components/num.dart';
import 'package:store_revision/feature/presentation/pages/product_add/components/revision_name.dart';

part 'product_add_state.dart';

@injectable
class ProductAddCubit extends Cubit<ProductAddState> {
  final CreateProductUseCase _createProductUseCase;
  ProductAddCubit(this._createProductUseCase)
      : super(ProductAddState.initial());

  void scannChanged(String value) {
    emit(state.copyWith(scannQr: value));
  }

  void costChanged(String value) {
    final cost = Num.dirty(value);
    emit(state.copyWith(
      cost: cost,
      status: Formz.validate([
        cost,
        state.name,
        state.quantity,
      ]),
    ));
  }

  void quantityChanged(String value) {
    final quantity = Num.dirty(value);
    emit(state.copyWith(
      quantity: quantity,
      status: Formz.validate([
        quantity,
        state.cost,
        state.name,
      ]),
    ));
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.cost,
        state.quantity,
      ]),
    ));
  }

  void resetState() {
    emit(ProductAddState.initial());
  }

  Future<void> createProduct({
    required String uid,
    required String revisionId,
    required String? userName,
    required String productName,
    required double productCost,
    required double productQuantity,
  }) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final result = await _createProductUseCase.call(CreateProductParams(
      uid: uid,
      revisionId: revisionId,
      name: productName,
      userName: userName ?? '',
      cost: productCost,
      quantity: productQuantity,
    ));
    await result.fold((failure) async {
      emit(ProductAddState.error(failure));
    }, (product) async {
      emit(ProductAddState.success());
      resetState();
    });
  }
}
