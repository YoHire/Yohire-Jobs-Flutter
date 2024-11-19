import 'package:openbn/core/utils/shared_services/models/recruiter/recruiter_model.dart';
import 'package:openbn/features/circle/domain/entities/queue_download_entity.dart';

class QueueDownloadModel extends QueueDownloadEntity {
  QueueDownloadModel({
    required super.id,
    required super.downloadDate,
    required super.recruiter,
  });

  factory QueueDownloadModel.fromJson(Map<String, dynamic> json) {
    return QueueDownloadModel(
      id: json['id'] ?? '',
      downloadDate: DateTime.parse(json['downloadedAt']),
      recruiter: json['recruiter'] != null
          ? RecruiterModel.fromJson(
              json['recruiter'] as Map<String, dynamic>)
          : null,
    );
  }
}
