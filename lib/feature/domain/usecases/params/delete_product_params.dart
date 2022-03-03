import 'package:equatable/equatable.dart';

class DeleteProductParams extends Equatable {
  final String revisionId;
  final String productId;

  const DeleteProductParams(
      {required this.revisionId, required this.productId});

  @override
  List<Object> get props => [revisionId, productId];
}
