// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_cache_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsCacheLocalModelAdapter
    extends TypeAdapter<ProductsCacheLocalModel> {
  @override
  final int typeId = 4;

  @override
  ProductsCacheLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsCacheLocalModel(
      (fields[0] as List).cast<ProductLocalModel>(),
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductsCacheLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.products)
      ..writeByte(1)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsCacheLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
