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
  final List<ProductRemoteModel> listProducts;
  @override
  final DateTime date;
  @override
  final String creatorName;
  @override
  final bool isClosed;
  @override
  final double score;

  const RevisionRemoteModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.listProducts,
    required this.date,
    required this.creatorName,
    required this.isClosed,
    required this.score,
  }) : super(
          id: id,
          uid: uid,
          name: name,
          description: description,
          listProducts: listProducts,
          date: date,
          creatorName: creatorName,
          isClosed: isClosed,
          score: score,
        );

  factory RevisionRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$RevisionRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RevisionRemoteModelToJson(this);
}

@JsonSerializable()
class ProductRemoteModel extends ProductEntity {
  @override
  final String num;
  @override
  final double cost;
  @override
  final double count;
  @override
  final double score;
  @override
  final String name;
  @override
  final DateTime datePublished;

  const ProductRemoteModel({
    required this.num,
    required this.cost,
    required this.count,
    required this.score,
    required this.name,
    required this.datePublished,
  }) : super(
          num: num,
          cost: cost,
          count: count,
          score: score,
          name: name,
          datePublished: datePublished,
        );

  factory ProductRemoteModel.from(ProductEntity product) => ProductRemoteModel(
        num: product.num,
        cost: product.cost,
        count: product.count,
        score: product.score,
        name: product.name,
        datePublished: product.datePublished,
      );

  factory ProductRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRemoteModelToJson(this);
}
