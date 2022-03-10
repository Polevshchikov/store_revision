import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String uid;
  final double cost;
  final double quantity;
  final double total;
  final String name;
  final DateTime datePublished;
  final String userName;

  const ProductEntity({
    required this.id,
    required this.uid,
    required this.cost, //  цена
    required this.quantity, //  количество
    required this.total, // итог
    required this.name,
    required this.userName,
    required this.datePublished,
  });

  @override
  List<Object> get props => [
        id,
        uid,
        cost,
        quantity,
        total,
        name,
        userName,
        datePublished,
      ];
}
