// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class EmpTrainingAdapter extends TypeAdapter<EmpTraining> {
  @override
  final typeId = 0;

  @override
  EmpTraining read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmpTraining(
      pernr: fields[0] as String,
      ename: fields[1] as String,
      persk: fields[2] as String,
      dept: fields[3] as String,
      inst: fields[4] as String,
      venue: fields[5] as String,
      progTitle: fields[6] as String,
      progCat: fields[7] as String,
      progType: fields[8] as String,
      begda: fields[9] as String,
      endda: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmpTraining obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.pernr)
      ..writeByte(1)
      ..write(obj.ename)
      ..writeByte(2)
      ..write(obj.persk)
      ..writeByte(3)
      ..write(obj.dept)
      ..writeByte(4)
      ..write(obj.inst)
      ..writeByte(5)
      ..write(obj.venue)
      ..writeByte(6)
      ..write(obj.progTitle)
      ..writeByte(7)
      ..write(obj.progCat)
      ..writeByte(8)
      ..write(obj.progType)
      ..writeByte(9)
      ..write(obj.begda)
      ..writeByte(10)
      ..write(obj.endda);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmpTrainingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
