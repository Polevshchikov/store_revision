import 'package:json_annotation/json_annotation.dart';
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

  const UserRemoteModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photo,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          photo: photo,
        );

  factory UserRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$UserRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRemoteModelToJson(this);
}
