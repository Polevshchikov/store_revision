// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductLocalModelAdapter extends TypeAdapter<ProductLocalModel> {
  @override
  final int typeId = 3;

  @override
  ProductLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductLocalModel(
      id: fields[0] as String,
      uid: fields[1] as String,
      cost: fields[2] as double,
      quantity: fields[3] as double,
      total: fields[4] as double,
      name: fields[5] as String,
      userName: fields[7] as String,
      datePublished: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductLocalModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.total)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.datePublished)
      ..writeByte(7)
      ..write(obj.userName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
