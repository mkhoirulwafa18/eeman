// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmAdapter extends TypeAdapter<Alarm> {
  @override
  final int typeId = 1;

  @override
  Alarm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Alarm()
      ..alarmList =
          fields[0] == null ? [] : (fields[0] as List?)?.cast<DateTime>();
  }

  @override
  void write(BinaryWriter writer, Alarm obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.alarmList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
