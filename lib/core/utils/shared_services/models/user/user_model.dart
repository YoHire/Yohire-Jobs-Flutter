import 'package:hive/hive.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/core/utils/shared_services/models/education/education_model.dart';
import 'package:openbn/core/utils/shared_services/models/experience/experience_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? username;

  @HiveField(2)
  final String? surname;

  @HiveField(3)
  final String? mobile;

  @HiveField(4)
  final String? email;

  @HiveField(5)
  final String? gender;

  @HiveField(6)
  final String? resume;

  @HiveField(7)
  final String? createdAt;

  @HiveField(8)
  final String? updatedAt;

  @HiveField(9)
  final String? bio;

  @HiveField(10)
  final String? height;

  @HiveField(11)
  final String? weight;

  @HiveField(12)
  final String? address;

  @HiveField(13)
  final String? dateOfBirth;

  @HiveField(14)
  final List<EducationModel> education;

  @HiveField(15)
  final String? profileImage;

  @HiveField(16)
  final List<ExperienceModel> experience;

  @HiveField(17)
  final List<SkillModel> skills;

  @HiveField(18)
  final List<JobRoleModel> prefrences;

  @HiveField(19)
  final List<LanguageModel> languagesSpeak;

  @HiveField(20)
  final List<LanguageModel> languagesReadAndWrite;

  @HiveField(21)
  final List<DocumentModel>documents;

  UserModel({
    required this.id,
    required this.username,
    required this.surname,
    required this.mobile,
    required this.email,
    required this.gender,
    required this.resume,
    required this.createdAt,
    required this.updatedAt,
    required this.education,
    required this.experience,
    required this.skills,
    required this.documents,
    required this.languagesReadAndWrite,
    required this.languagesSpeak,
    required this.prefrences,
    required this.bio,
    required this.height,
    required this.weight,
    required this.address,
    required this.dateOfBirth,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      surname: json['surname'] ?? '',
      profileImage: json['profileImage'],
      mobile: json['mobile'],
      email: json['email'],
      gender: json['gender'] ?? '',
      resume: json['resumeLink'] ?? '',
      createdAt: json['createdAt'],
      bio: json['bio'] ?? '',
      height: json['height'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      address: json['address'] ?? '',
      weight: json['weight'] ?? '',
      updatedAt: json['updatedAt'],
      education: json['education'] != null
          ? (json['education'] as List)
              .map((e) => EducationModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      experience: json['experience'] != null
          ? (json['experience'] as List)
              .map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      skills: json['skills'] != null
          ? (json['skills'] as List)
              .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      prefrences: json['prefrences'] != null
          ? (json['prefrences'] as List)
              .map((e) => JobRoleModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      documents: json['documents'] != null
          ? (json['documents'] as List)
              .map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      languagesReadAndWrite: json['language'] != null
          ? (json['language'] as List)
              .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      languagesSpeak: json['language'] != null
          ? (json['language'] as List)
              .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'surname': surname,
        'mobile': mobile,
        'email': email,
        'gender': gender,
        'resume': resume,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
