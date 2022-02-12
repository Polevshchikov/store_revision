import 'package:equatable/equatable.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

class RevisionEntity extends Equatable {
  final List<ProductEntity> listProducts;
  final String name;
  final DateTime date;
  final String id;
  final String creatorName;

  const RevisionEntity({
    required this.listProducts,
    required this.name,
    required this.date,
    required this.id,
    required this.creatorName,
  });

  @override
  List<Object> get props => [
        listProducts,
        name,
        date,
        id,
        creatorName,
      ];
}
