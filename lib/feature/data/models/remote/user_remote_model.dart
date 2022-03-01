// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';

part 'user_remote_model.g.dart';

@JsonSerializable()
class UserRemoteModel extends UserEntity {
  @override
  final String uid;
  @override
  final String email;
  @override
  final String name;
  @override
  final String photo;
  @override
  final List<RevisionRemoteModel> revisions;

  const UserRemoteModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photo,
    required this.revisions,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          photo: photo,
          revisions: revisions,
        );

  factory UserRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$UserRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRemoteModelToJson(this);
}

@JsonSerializable()
class RevisionRemoteModel extends RevisionEntity {
  @override
  final String id;
  @override
  final String uid;
  @override
  final String name;
  @override
  final String description;
  @override
  final List<String> listTrusted;
  @override
  final List<String> listProducts;
  @override
  final DateTime date;
  @override
  final bool isClosed;
  @override
  final double total;

  const RevisionRemoteModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.listTrusted,
    required this.listProducts,
    required this.date,
    required this.isClosed,
    required this.total,
  }) : super(
          id: id,
          uid: uid,
          name: name,
          description: description,
          listTrusted: listTrusted,
          listProducts: listProducts,
          date: date,
          isClosed: isClosed,
          total: total,
        );

  factory RevisionRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$RevisionRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RevisionRemoteModelToJson(this);
}

@JsonSerializable()
class ProductRemoteModel extends ProductEntity {
  @override
  final String id;
  @override
  final String uid;
  @override
  final double cost;
  @override
  final double count;
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
    required this.count,
    required this.total,
    required this.name,
    required this.userName,
    required this.datePublished,
  }) : super(
          id: id,
          uid: uid,
          cost: cost,
          count: count,
          total: total,
          name: name,
          userName: userName,
          datePublished: datePublished,
        );

  factory ProductRemoteModel.from(ProductEntity product) => ProductRemoteModel(
        id: product.id,
        uid: product.uid,
        cost: product.cost,
        count: product.count,
        total: product.total,
        name: product.name,
        userName: product.userName,
        datePublished: product.datePublished,
      );

  factory ProductRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRemoteModelToJson(this);
}
