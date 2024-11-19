import 'package:openbn/core/utils/shared_services/models/recruiter/recruiter_model.dart';

class InvitedJobEntity {
  final String id;
  final DateTime createdAt;
  final String jobTitle;
  final String description;
  final RecruiterModel? recruiter;

  InvitedJobEntity({
    required this.id,
    required this.jobTitle,
    required this.description,
    required this.recruiter,
    required this.createdAt,
  });
}