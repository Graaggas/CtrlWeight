// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightModelAdapter extends TypeAdapter<WeightModel> {
  @override
  final int typeId = 1;

  @override
  WeightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightModel()
      .._weightMap = (fields[1] as Map)?.cast<DateTime, double>()
      .._wantedWeight = fields[2] as double
      .._startWeightForCalculating = fields[3] as double;
  }

  @override
  void write(BinaryWriter writer, WeightModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj._weightMap)
      ..writeByte(2)
      ..write(obj._wantedWeight)
      ..writeByte(3)
      ..write(obj._startWeightForCalculating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WaisteModelAdapter extends TypeAdapter<WaisteModel> {
  @override
  final int typeId = 2;

  @override
  WaisteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaisteModel()
      .._waisteMap = (fields[1] as Map)?.cast<DateTime, double>()
      .._wantedWaiste = fields[2] as double
      .._startWaisteForCalculating = fields[3] as double
      .._height = fields[4] as double;
  }

  @override
  void write(BinaryWriter writer, WaisteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj._waisteMap)
      ..writeByte(2)
      ..write(obj._wantedWaiste)
      ..writeByte(3)
      ..write(obj._startWaisteForCalculating)
      ..writeByte(4)
      ..write(obj._height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaisteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IsFirstMeetingFlaggingAdapter
    extends TypeAdapter<IsFirstMeetingFlagging> {
  @override
  final int typeId = 3;

  @override
  IsFirstMeetingFlagging read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsFirstMeetingFlagging()..isFirstMeetingFlag = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, IsFirstMeetingFlagging obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.isFirstMeetingFlag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsFirstMeetingFlaggingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
