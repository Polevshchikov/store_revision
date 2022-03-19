// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';

part 'user_local_model.g.dart';

const userBoxKey = 'userBox';

@HiveType(typeId: 1)
class UserLocalModel extends UserEntity {
  @override
  @HiveField(0)
  final String uid;
  @override
  @HiveField(1)
  final String email;
  @override
  @HiveField(2)
  final String name;
  @override
  @HiveField(3)
  final String photo;
  @override
  @HiveField(4)
  final List<String> revisions;

  const UserLocalModel({
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

  factory UserLocalModel.from(UserEntity user) => UserLocalModel(
        uid: user.uid,
        email: user.email,
        name: user.name,
        photo: user.photo,
        revisions: user.revisions,
      );
}
