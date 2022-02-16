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
      listProducts: (json['listProducts'] as List<dynamic>)
          .map((e) => ProductRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: DateTime.parse(json['date'] as String),
      creatorName: json['creatorName'] as String,
      isClosed: json['isClosed'] as bool,
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$RevisionRemoteModelToJson(
        RevisionRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'description': instance.description,
      'listProducts': instance.listProducts,
      'date': instance.date.toIso8601String(),
      'creatorName': instance.creatorName,
      'isClosed': instance.isClosed,
      'score': instance.score,
    };

ProductRemoteModel _$ProductRemoteModelFromJson(Map<String, dynamic> json) =>
    ProductRemoteModel(
      num: json['num'] as String,
      cost: (json['cost'] as num).toDouble(),
      count: (json['count'] as num).toDouble(),
      score: (json['score'] as num).toDouble(),
      name: json['name'] as String,
      datePublished: DateTime.parse(json['datePublished'] as String),
    );

Map<String, dynamic> _$ProductRemoteModelToJson(ProductRemoteModel instance) =>
    <String, dynamic>{
      'num': instance.num,
      'cost': instance.cost,
      'count': instance.count,
      'score': instance.score,
      'name': instance.name,
      'datePublished': instance.datePublished.toIso8601String(),
    };
