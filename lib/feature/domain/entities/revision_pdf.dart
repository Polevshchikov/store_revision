import 'package:equatable/equatable.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

class RevisionPDF extends Equatable {
  final String revisoinId;
  final String revisoinName;
  final String revisoinDescr;
  final List<String> namesTrusted;
  final List<ProductEntity> listProducts;
  final DateTime createDate;
  final double total;

  const RevisionPDF({
    required this.revisoinId,
    required this.revisoinName,
    required this.revisoinDescr,
    required this.namesTrusted,
    required this.listProducts,
    required this.createDate,
    required this.total,
  });
  @override
  List<Object> get props => [
        revisoinId,
        revisoinName,
        revisoinDescr,
        namesTrusted,
        listProducts,
        createDate,
        total,
      ];
}
