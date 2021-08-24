// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineModelAdapter extends TypeAdapter<RoutineModel> {
  @override
  final int typeId = 2;

  @override
  RoutineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineModel(
      routine: fields[0] as String,
      dateTime: fields[1] as DateTime,
      isFinish: fields[2] as bool,
      isNotifaction: fields[3] as bool,
      time: fields[4] as String,
      notificationTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RoutineModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.routine)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.isFinish)
      ..writeByte(3)
      ..write(obj.isNotifaction)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.notificationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
