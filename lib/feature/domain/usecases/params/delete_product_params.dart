import 'package:equatable/equatable.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

class DeleteProductParams extends Equatable {
  final String revisionId;
  final ProductEntity product;

  const DeleteProductParams({required this.revisionId, required this.product});

  @override
  List<Object> get props => [revisionId, product];
}
