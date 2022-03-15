// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

part 'revision_remote_model.g.dart';

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
