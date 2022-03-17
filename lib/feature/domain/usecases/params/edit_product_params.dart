import 'package:equatable/equatable.dart';

class EditProductParams extends Equatable {
  final String revisionId;
  final String productId;
  final String productName;
  final double productCost;
  final double productQuantity;

  const EditProductParams({
    required this.revisionId,
    required this.productId,
    required this.productName,
    required this.productCost,
    required this.productQuantity,
  });

  @override
  List<Object> get props => [
        revisionId,
        productId,
        productName,
        productCost,
        productQuantity,
      ];
}
