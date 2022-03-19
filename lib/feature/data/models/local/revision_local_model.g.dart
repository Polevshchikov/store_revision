// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionLocalModelAdapter extends TypeAdapter<RevisionLocalModel> {
  @override
  final int typeId = 5;

  @override
  RevisionLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionLocalModel(
      id: fields[0] as String,
      uid: fields[1] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      listTrusted: (fields[4] as List).cast<String>(),
      listProducts: (fields[5] as List).cast<String>(),
      date: fields[6] as DateTime,
      isClosed: fields[7] as bool,
      total: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RevisionLocalModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.listTrusted)
      ..writeByte(5)
      ..write(obj.listProducts)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.isClosed)
      ..writeByte(8)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
