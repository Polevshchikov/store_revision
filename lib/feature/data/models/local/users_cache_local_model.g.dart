// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_cache_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersCacheLocalModelAdapter extends TypeAdapter<UsersCacheLocalModel> {
  @override
  final int typeId = 2;

  @override
  UsersCacheLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersCacheLocalModel(
      (fields[0] as List).cast<UserLocalModel>(),
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UsersCacheLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.users)
      ..writeByte(1)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersCacheLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
