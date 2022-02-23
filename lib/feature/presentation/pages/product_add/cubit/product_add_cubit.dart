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
  ProductAddCubit(this._createProductUseCase) : super(const ProductAddState());

  void costChanged(String value) {
    final cost = Num.dirty(value);
    emit(state.copyWith(
      cost: cost,
      status: Formz.validate([cost]),
    ));
  }

  void countChanged(String value) {
    final count = Num.dirty(value);
    emit(state.copyWith(
      count: count,
      status: Formz.validate([count]),
    ));
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name]),
    ));
  }

  Future<void> createProduct({
    required String uid,
    required String revisionId,
    required String? userName,
  }) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final result = await _createProductUseCase.call(CreateProductParams(
      uid: uid,
      revisionId: revisionId,
      name: state.name.value,
      userName: userName ?? '',
      cost: state.cost.value,
      count: state.count.value,
    ));
    await result.fold((failure) async {
      emit(state.copyWith(
        failure: failure,
        status: FormzStatus.submissionFailure,
      ));
    }, (product) async {
      emit(state.copyWith(
          name: const Name.pure(),
          cost: const Num.pure(),
          count: const Num.pure(),
          status: FormzStatus.submissionSuccess));
    });
  }
}
