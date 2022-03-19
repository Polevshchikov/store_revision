import 'package:hive/hive.dart';
import 'package:store_revision/feature/data/models/local/revision_local_model.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

part 'revisions_cache_local_model.g.dart';

const revisionsCacheBoxKey = 'revisionsCacheBox';

@HiveType(typeId: 6)
class RevisionsCacheLocalModel {
  @HiveField(0)
  final List<RevisionLocalModel> revisions;
  @HiveField(1)
  final String createdAt;

  RevisionsCacheLocalModel(
    this.revisions,
    this.createdAt,
  );

  factory RevisionsCacheLocalModel.from(List<RevisionEntity> revisions) =>
      RevisionsCacheLocalModel(
        revisions.map((revision) => RevisionLocalModel.from(revision)).toList(),
        DateTime.now().toIso8601String(),
      );
}
