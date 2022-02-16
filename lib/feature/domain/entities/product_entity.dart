import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String num;
  final double cost;
  final double count;
  final double score;
  final String name;
  final DateTime datePublished;

  const ProductEntity({
    required this.num,
    required this.cost,
    required this.count,
    required this.score,
    required this.name,
    required this.datePublished,
  });

  @override
  List<Object> get props => [
        num,
        cost,
        count,
        score,
        name,
        datePublished,
      ];
}
