// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

part 'product_remote_model.g.dart';

@JsonSerializable()
class ProductRemoteModel extends ProductEntity {
  @override
  final String id;
  @override
  final String uid;
  @override
  final double cost;
  @override
  final double quantity;
  @override
  final double total;
  @override
  final String name;
  @override
  final String userName;
  @override
  final DateTime datePublished;

  const ProductRemoteModel({
    required this.id,
    required this.uid,
    required this.cost,
    required this.quantity,
    required this.total,
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

  factory ProductRemoteModel.from(ProductEntity product) => ProductRemoteModel(
        id: product.id,
        uid: product.uid,
        cost: product.cost,
        quantity: product.quantity,
        total: product.total,
        name: product.name,
        userName: product.userName,
        datePublished: product.datePublished,
      );

  factory ProductRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRemoteModelToJson(this);
}
