import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:openbn/core/utils/shared_services/user/models/education_model/education_model.dart';
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
