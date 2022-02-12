import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String num;
  final double cost;
  final double count;
  final String name;
  final String creatorName;

  const ProductEntity({
    required this.num,
    required this.cost,
    required this.count,
    required this.name,
    required this.creatorName,
  });

  @override
  List<Object> get props => [
        num,
        cost,
        count,
        name,
        creatorName,
      ];
}
