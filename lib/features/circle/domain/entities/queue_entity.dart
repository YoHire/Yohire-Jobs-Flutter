
//Queue Display Model
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/circle/domain/entities/queue_download_entity.dart';
import 'package:openbn/features/circle/domain/entities/queue_invitation_entity.dart';

class QueueEntity {
  final String userId;
  final String id;
  final String jobRoleId;
  final JobRoleModel jobRole;
  final List<String>? countriesId;
  final List<CountryModel> countries;
  final List<QueueDownloadEntity> downloads;
  final List<InvitationEntity> invitations;
  final double salaryStart;
  final double salaryEnd;
  final int viewCount;
  final int clickedCount;
  final String coverLetter;
  final DateTime expiryDate;
  final DateTime startDate;
  final DateTime lastUpdated;

  QueueEntity({
    required this.id,
    required this.clickedCount,
    required this.viewCount,
    required this.userId,
    required this.jobRoleId,
    this.countriesId,
    required this.countries,
    required this.downloads,
    required this.invitations,
    required this.salaryStart,
    required this.salaryEnd,
    required this.coverLetter,
    required this.expiryDate,
    required this.jobRole,
    required this.startDate,
    required this.lastUpdated,
  });
}

