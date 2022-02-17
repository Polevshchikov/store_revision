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
      revisions: (json['revisions'] as List<dynamic>)
          .map((e) => RevisionRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserRemoteModelToJson(UserRemoteModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
      'revisions': instance.revisions,
    };

RevisionRemoteModel _$RevisionRemoteModelFromJson(Map<String, dynamic> json) =>
    RevisionRemoteModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      listTrusted: (json['listTrusted'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      date: DateTime.parse(json['date'] as String),
      isClosed: json['isClosed'] as bool,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$RevisionRemoteModelToJson(
        RevisionRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'description': instance.description,
      'listTrusted': instance.listTrusted,
      'date': instance.date.toIso8601String(),
      'isClosed': instance.isClosed,
      'total': instance.total,
    };

ProductRemoteModel _$ProductRemoteModelFromJson(Map<String, dynamic> json) =>
    ProductRemoteModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      cost: (json['cost'] as num).toDouble(),
      count: (json['count'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      name: json['name'] as String,
      userName: json['userName'] as String,
      datePublished: DateTime.parse(json['datePublished'] as String),
    );

Map<String, dynamic> _$ProductRemoteModelToJson(ProductRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'cost': instance.cost,
      'count': instance.count,
      'total': instance.total,
      'name': instance.name,
      'userName': instance.userName,
      'datePublished': instance.datePublished.toIso8601String(),
    };
