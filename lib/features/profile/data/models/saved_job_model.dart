import 'dart:developer';

import 'package:openbn/features/profile/domain/entity/saved_job_entity.dart';

class SavedJobModel extends SavedJobEntity {
  SavedJobModel(
      {required super.id, required super.title, required super.location});

  factory SavedJobModel.fromJson(Map<String, dynamic> json) {
    return SavedJobModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
