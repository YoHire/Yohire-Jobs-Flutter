// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducationModelAdapter extends TypeAdapter<EducationModel> {
  @override
  final int typeId = 1;

  @override
  EducationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducationModel(
      institution: fields[2] as String,
      dateOfCompletion: fields[5] as DateTime,
      id: fields[0] as String?,
      courseData: fields[4] as CourseModel?,
      courseId: fields[3] as String?,
      userId: fields[8] as String,
      certificateUrl: fields[6] as String,
      level: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EducationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.institution)
      ..writeByte(3)
      ..write(obj.courseId)
      ..writeByte(4)
      ..write(obj.courseData)
      ..writeByte(5)
      ..write(obj.dateOfCompletion)
      ..writeByte(6)
      ..write(obj.certificateUrl)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
