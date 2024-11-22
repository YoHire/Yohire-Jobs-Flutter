import 'package:openbn/features/profile/domain/entity/applied_job_entity.dart';

class AppliedJobModel extends AppliedJobEntity {
  AppliedJobModel(
      {required super.id,
      required super.title,
      required super.location,
      required super.isResumeDownloaded});
  factory AppliedJobModel.fromJson(
      Map<String, dynamic> json, bool isResumeDownloaded) {
    return AppliedJobModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        location: json['location'] ?? '',
        isResumeDownloaded: isResumeDownloaded);
  }
}
