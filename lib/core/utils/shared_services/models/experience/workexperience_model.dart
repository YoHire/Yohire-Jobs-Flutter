import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
part 'workexperience_model.g.dart';

@HiveType(typeId: 3)
class WorkExperienceModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String company;

  @HiveField(2)
  final JobRoleModel? designation;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  String certificateUrl;

  @HiveField(5)
  final DateTime? endDate;

  @HiveField(6)
  final String userId;

  @HiveField(7)
  final CountryModel? country;

  WorkExperienceModel({
    required this.company,
    required this.startDate,
    this.country,
    this.endDate,
    this.id,
    this.designation,
    required this.userId,
    required this.certificateUrl,
  });

  // JSON serialization
  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
        id: json['id'] ?? '',
        company: json['companyName'] ?? '',
        designation: json['jobRoles'] != null
            ? JobRoleModel.fromJson(json['jobRoles'][0])
            : null,
        startDate: DateTime.parse(json['startDate']),
        certificateUrl: json['certificate'] ?? '',
        endDate:
            json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        userId: json['userId'] ?? '',
        country: json['country'] != null
            ? CountryModel.fromJson(json['country'])
            : CountryModel(id: '', name: ''));
  }
}
