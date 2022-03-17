part of 'change_body_to_cubit.dart';

class ChangeBodyToState extends Equatable {
  final String revisionId;
  final String productId;
  final String productName;
  final double productCost;
  final double productQuantity;
  final ChangeBodyType changeBodyType;

  const ChangeBodyToState._({
    this.revisionId = '',
    this.productId = '',
    this.productName = '',
    this.productCost = -1,
    this.productQuantity = -1,
    this.changeBodyType = ChangeBodyType.revision,
  });

  factory ChangeBodyToState.showProductAdd() =>
      const ChangeBodyToState._(changeBodyType: ChangeBodyType.addProduct);

  factory ChangeBodyToState.showRevision() =>
      const ChangeBodyToState._(changeBodyType: ChangeBodyType.revision);

  factory ChangeBodyToState.showProductEdit({
    required String revisionId,
    required String productId,
    required String productName,
    required double productCost,
    required double productQuantity,
  }) =>
      ChangeBodyToState._(
          revisionId: revisionId,
          productId: productId,
          productName: productName,
          productCost: productCost,
          productQuantity: productQuantity,
          changeBodyType: ChangeBodyType.editProduct);

  @override
  List<Object> get props => [
        revisionId,
        productId,
        productName,
        productCost,
        productQuantity,
        changeBodyType,
      ];
}

enum ChangeBodyType {
  addProduct,
  editProduct,
  revision,
}
