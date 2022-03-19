// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

part 'product_local_model.g.dart';

const productBoxKey = 'productBox';

@HiveType(typeId: 3)
class ProductLocalModel extends ProductEntity {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String uid;
  @override
  @HiveField(2)
  final double cost;
  @override
  @HiveField(3)
  final double quantity;
  @override
  @HiveField(4)
  final double total;
  @override
  @HiveField(5)
  final String name;
  @override
  @HiveField(6)
  final DateTime datePublished;
  @override
  @HiveField(7)
  final String userName;

  const ProductLocalModel({
    required this.id,
    required this.uid,
    required this.cost, //  цена
    required this.quantity, //  количество
    required this.total, // итог
    required this.name,
    required this.userName,
    required this.datePublished,
  }) : super(
          id: id,
          uid: uid,
          cost: cost,
          quantity: quantity,
          total: total,
          name: name,
          userName: userName,
          datePublished: datePublished,
        );

  factory ProductLocalModel.from(ProductEntity product) => ProductLocalModel(
        id: product.id,
        uid: product.uid,
        cost: product.cost,
        quantity: product.quantity,
        total: product.total,
        name: product.name,
        userName: product.userName,
        datePublished: product.datePublished,
      );
}
