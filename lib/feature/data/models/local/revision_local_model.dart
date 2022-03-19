// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

part 'revision_local_model.g.dart';

const revisionBoxKey = 'revisionBox';

@HiveType(typeId: 5)
class RevisionLocalModel extends RevisionEntity {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String uid;
  @override
  @HiveField(2)
  final String name;
  @override
  @HiveField(3)
  final String description;
  @override
  @HiveField(4)
  final List<String> listTrusted;
  @override
  @HiveField(5)
  final List<String> listProducts;
  @override
  @HiveField(6)
  final DateTime date;
  @override
  @HiveField(7)
  final bool isClosed;
  @override
  @HiveField(8)
  final double total;

  const RevisionLocalModel({
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

  factory RevisionLocalModel.from(RevisionEntity revision) =>
      RevisionLocalModel(
        id: revision.id,
        uid: revision.uid,
        name: revision.name,
        description: revision.description,
        listTrusted: revision.listTrusted,
        listProducts: revision.listProducts,
        date: revision.date,
        isClosed: revision.isClosed,
        total: revision.total,
      );
}
