// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      username: fields[1] as String?,
      surname: fields[2] as String?,
      mobile: fields[3] as String?,
      email: fields[4] as String?,
      gender: fields[5] as String?,
      resume: fields[6] as String?,
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
      education: (fields[14] as List).cast<EducationModel>(),
      experience: (fields[16] as List).cast<ExperienceModel>(),
      skills: (fields[17] as List).cast<SkillModel>(),
      documents: (fields[21] as List).cast<DocumentModel>(),
      languagesReadAndWrite: (fields[20] as List).cast<LanguageModel>(),
      languagesSpeak: (fields[19] as List).cast<LanguageModel>(),
      prefrences: (fields[18] as List).cast<JobRoleModel>(),
      bio: fields[9] as String?,
      height: fields[10] as String?,
      weight: fields[11] as String?,
      address: fields[12] as String?,
      dateOfBirth: fields[13] as String?,
      profileImage: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.surname)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.resume)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.bio)
      ..writeByte(10)
      ..write(obj.height)
      ..writeByte(11)
      ..write(obj.weight)
      ..writeByte(12)
      ..write(obj.address)
      ..writeByte(13)
      ..write(obj.dateOfBirth)
      ..writeByte(14)
      ..write(obj.education)
      ..writeByte(15)
      ..write(obj.profileImage)
      ..writeByte(16)
      ..write(obj.experience)
      ..writeByte(17)
      ..write(obj.skills)
      ..writeByte(18)
      ..write(obj.prefrences)
      ..writeByte(19)
      ..write(obj.languagesSpeak)
      ..writeByte(20)
      ..write(obj.languagesReadAndWrite)
      ..writeByte(21)
      ..write(obj.documents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
