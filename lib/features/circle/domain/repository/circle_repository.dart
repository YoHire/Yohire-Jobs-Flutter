import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/circle/domain/entities/queue_entity.dart';
import 'package:openbn/features/circle/domain/entities/queue_invitation_entity.dart';

abstract interface class CircleRepository {
  Future<Either<Failure, List<QueueEntity>>> getAllQueues();
  Future<Either<Failure, List<InvitationEntity>>> getAllInvitations(
      {required String queueId});
  Future<Either<Failure, void>> joinQueue(
      {required JobRoleModel jobRole,
      required List<CountryModel> countries,
      required double salaryStart,
      required double salaryEnd,
      required String bio});
}
