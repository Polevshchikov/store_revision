// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRemoteModel _$UserRemoteModelFromJson(Map<String, dynamic> json) =>
    UserRemoteModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$UserRemoteModelToJson(UserRemoteModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
    };
