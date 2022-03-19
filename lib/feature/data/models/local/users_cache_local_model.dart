import 'package:hive/hive.dart';
import 'package:store_revision/feature/data/models/local/user_local_model.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';

part 'users_cache_local_model.g.dart';

const usersCacheBoxKey = 'usersCacheBox';

@HiveType(typeId: 2)
class UsersCacheLocalModel {
  @HiveField(0)
  final List<UserLocalModel> users;
  @HiveField(1)
  final String createdAt;

  UsersCacheLocalModel(
    this.users,
    this.createdAt,
  );

  factory UsersCacheLocalModel.from(List<UserEntity> users) =>
      UsersCacheLocalModel(
        users.map((user) => UserLocalModel.from(user)).toList(),
        DateTime.now().toIso8601String(),
      );
}
