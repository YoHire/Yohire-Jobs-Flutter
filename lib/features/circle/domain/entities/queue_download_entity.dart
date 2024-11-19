import 'package:openbn/core/utils/shared_services/models/recruiter/recruiter_model.dart';

class QueueDownloadEntity {
  final String? id;
  final DateTime downloadDate;
  final RecruiterModel? recruiter;

  QueueDownloadEntity(
      {required this.id, required this.downloadDate, required this.recruiter});
}