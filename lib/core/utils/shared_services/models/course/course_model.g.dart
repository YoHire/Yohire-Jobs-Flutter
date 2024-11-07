// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseModelAdapter extends TypeAdapter<CourseModel> {
  @override
  final int typeId = 2;

  @override
  CourseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseModel(
      id: fields[1] as String,
      course: fields[2] as String,
      category: fields[3] as String,
      subCategory: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CourseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.course)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
