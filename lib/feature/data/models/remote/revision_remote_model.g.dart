// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevisionRemoteModel _$RevisionRemoteModelFromJson(Map<String, dynamic> json) =>
    RevisionRemoteModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      listTrusted: (json['listTrusted'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      listProducts: (json['listProducts'] as List<dynamic>)
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
      'listProducts': instance.listProducts,
      'date': instance.date.toIso8601String(),
      'isClosed': instance.isClosed,
      'total': instance.total,
    };
