import 'package:openbn/features/circle/domain/entities/queue_invitation_entity.dart';
import 'queue_invited_job_model.dart';

class InvitationModel extends InvitationEntity {
  InvitationModel({
    required super.id,
    required super.invitedJob,
    required super.status,
    required super.createdAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      invitedJob: json['invitedJob'] != null
          ? InvitedJobModel.fromJson(json['invitedJob'] as Map<String, dynamic>)
          : null,
    );
  }
}
