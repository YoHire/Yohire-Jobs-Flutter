import 'dart:developer';

import 'package:hive/hive.dart';
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
  final bool? completedProfile;

  @HiveField(6)
  final String? gender;

  @HiveField(7)
  final String? resume;

  @HiveField(8)
  final String? createdAt;

  @HiveField(9)
  final String? updatedAt;

  UserModel({
    required this.id,
    required this.username,
    required this.surname,
    required this.mobile,
    required this.email,
    required this.completedProfile,
    required this.gender,
    required this.resume,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      surname: json['surname'] ?? '',
      mobile: json['mobile'],
      email: json['email'],
      completedProfile: json['completedProfile'],
      gender: json['gender'] ?? '',
      resume: json['resumeLink'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'surname': surname,
        'mobile': mobile,
        'email': email,
        'completedProfile': completedProfile,
        'gender': gender,
        'resume': resume,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
