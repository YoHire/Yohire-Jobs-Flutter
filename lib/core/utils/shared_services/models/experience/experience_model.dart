import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
part 'experience_model.g.dart';

@HiveType(typeId: 3)
class ExperienceModel {
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

  ExperienceModel({
    required this.company,
    required this.startDate,
    this.endDate,
    this.id,
    this.designation,
    required this.userId,
    required this.certificateUrl,
  });

  // JSON serialization
  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as String?,
      company: json['company'] as String,
      designation: json['designation'] != null
          ? JobRoleModel.fromJson(json['designation'])
          : null,
      startDate: DateTime.parse(json['startDate'] as String),
      certificateUrl: json['certificateUrl'] as String,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'designation': designation?.toJson(),
      'startDate': startDate.toIso8601String(),
      'certificateUrl': certificateUrl,
      'endDate': endDate?.toIso8601String(),
      'userId': userId,
    };
  }
}
