// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workexperience_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkExperienceModelAdapter extends TypeAdapter<WorkExperienceModel> {
  @override
  final int typeId = 3;

  @override
  WorkExperienceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkExperienceModel(
      company: fields[1] as String,
      startDate: fields[3] as DateTime,
      country: fields[7] as CountryModel?,
      endDate: fields[5] as DateTime?,
      id: fields[0] as String?,
      designation: fields[2] as JobRoleModel?,
      userId: fields[6] as String,
      certificateUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkExperienceModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.company)
      ..writeByte(2)
      ..write(obj.designation)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.certificateUrl)
      ..writeByte(5)
      ..write(obj.endDate)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkExperienceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
