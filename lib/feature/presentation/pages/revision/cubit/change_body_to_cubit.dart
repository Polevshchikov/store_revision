import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'change_body_to_state.dart';

@injectable
class ChangeBodyToCubit extends Cubit<ChangeBodyToState> {
  ChangeBodyToCubit() : super(ChangeBodyToState.showRevision());

  void changeToRevision() => emit(ChangeBodyToState.showRevision());
  void changeToAddProduct() => emit(ChangeBodyToState.showProductAdd());
  void changeToEditProduct({
    required String revisionId,
    required String productId,
    required String productName,
    required double productCost,
    required double productQuantity,
  }) =>
      emit(ChangeBodyToState.showProductEdit(
        revisionId: revisionId,
        productId: productId,
        productName: productName,
        productCost: productCost,
        productQuantity: productQuantity,
      ));
}
