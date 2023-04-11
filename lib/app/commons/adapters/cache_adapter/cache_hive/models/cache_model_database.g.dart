// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_model_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheModelDatabaseAdapter extends TypeAdapter<CacheModelDatabase> {
  @override
  final int typeId = 1;

  @override
  CacheModelDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheModelDatabase(
      id: fields[0] as String,
      data: (fields[2] as Map).cast<String, dynamic>(),
      date: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CacheModelDatabase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheModelDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
