import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/circle/data/models/queue_download_model.dart';
import 'package:openbn/features/circle/data/models/queue_invitation_model.dart';
import 'package:openbn/features/circle/domain/entities/queue_entity.dart';

class QueueModel extends QueueEntity {
  QueueModel(
      {required super.id,
      required super.clickedCount,
      required super.viewCount,
      required super.userId,
      required super.jobRoleId,
      required super.countries,
      required super.downloads,
      required super.invitations,
      required super.salaryStart,
      required super.salaryEnd,
      required super.coverLetter,
      required super.expiryDate,
      required super.jobRole,
      required super.startDate,
      required super.lastUpdated});
  Map<String, dynamic> toJson() {
    return {
      'queueId': id,
      'userId': userId,
      'jobRoleId': jobRoleId,
      'countries': countriesId,
      'salary-start': salaryStart,
      'salary-end': salaryEnd,
      'bio': coverLetter,
    };
  }

  factory QueueModel.fromJson(Map<String, dynamic> json) {
    return QueueModel(
        id: json['id'] ?? '',
        startDate: DateTime.parse(json['createdAt']),
        viewCount: json['viewCount'] ?? '',
        clickedCount: json['clickedCount'] ?? '',
        lastUpdated: DateTime.parse(json['updatedAt']),
        userId: json['usersId'] ?? '',
        jobRoleId: json['jobRoleId'] ?? '',
        expiryDate: DateTime.parse(json['expiryDate']),
        countries: json['interestedCountries'] != null
            ? (json['interestedCountries'] as List)
                .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        downloads: json['downloads'] != null
            ? (json['downloads'] as List)
                .map((e) =>
                    QueueDownloadModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        invitations: json['invitations'] != null
            ? (json['invitations'] as List)
                .map((e) => InvitationModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        salaryStart: double.parse(json['salaryStarting'].toString()),
        salaryEnd: double.parse(json['salaryEnding'].toString()),
        coverLetter: json['coverLetterUrl'] ?? '',
        jobRole: JobRoleModel.fromJson(json['jobRoles'][0]));
  }
}
