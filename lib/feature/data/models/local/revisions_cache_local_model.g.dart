// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revisions_cache_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionsCacheLocalModelAdapter
    extends TypeAdapter<RevisionsCacheLocalModel> {
  @override
  final int typeId = 6;

  @override
  RevisionsCacheLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionsCacheLocalModel(
      (fields[0] as List).cast<RevisionLocalModel>(),
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RevisionsCacheLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.revisions)
      ..writeByte(1)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionsCacheLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
