// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRemoteModel _$ProductRemoteModelFromJson(Map<String, dynamic> json) =>
    ProductRemoteModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      cost: (json['cost'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
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
      'quantity': instance.quantity,
      'total': instance.total,
      'name': instance.name,
      'userName': instance.userName,
      'datePublished': instance.datePublished.toIso8601String(),
    };
