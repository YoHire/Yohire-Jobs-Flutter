import 'package:openbn/core/utils/shared_services/models/recruiter/recruiter_model.dart';
import 'package:openbn/features/circle/domain/entities/queue_invited_job_entity.dart';

class InvitedJobModel extends InvitedJobEntity {
  InvitedJobModel({
    required super.id,
    required super.jobTitle,
    required super.description,
    required super.recruiter,
    required super.createdAt,
  });

  factory InvitedJobModel.fromJson(Map<String, dynamic> json) {
    return InvitedJobModel(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      jobTitle: json['jobTitle'] ?? '',
      description: json['jobDescription'] ?? '',
      recruiter: json['recruiter'] != null
          ? RecruiterModel.fromJson(
              json['recruiter'] as Map<String, dynamic>)
          : null,
    );
  }
}
