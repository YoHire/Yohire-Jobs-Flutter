import 'package:openbn/features/circle/domain/entities/queue_invited_job_entity.dart';

class InvitationEntity {
  final String id;
  final DateTime createdAt;
  final InvitedJobEntity? invitedJob;
  final String status;

  InvitationEntity({
    required this.id,
    required this.invitedJob,
    required this.status,
    required this.createdAt,
  });
}