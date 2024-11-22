import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/circle/data/datasource/circle_remote_datasource.dart';
import 'package:openbn/features/circle/data/models/queue_invitation_model.dart';
import 'package:openbn/features/circle/data/models/queue_model.dart';
import 'package:openbn/features/circle/domain/repository/circle_repository.dart';

class CircleRepositoryImpl implements CircleRepository {
  final CircleRemoteDatasource datasource;

  CircleRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<QueueModel>>> getAllQueues() async {
    try {
      final data = await datasource.getQueues();
      List<dynamic> results = data['data'];
      return Right(results.map((json) => QueueModel.fromJson(json)).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvitationModel>>> getAllInvitations(
      {required String queueId}) async {
    try {
      final data = await datasource.getInvitations(queueId: queueId);
      List<dynamic> results = data['data'];
      return Right(
          results.map((json) => InvitationModel.fromJson(json)).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinQueue(
      {required JobRoleModel jobRole,
      required List<CountryModel> countries,
      required double salaryStart,
      required double salaryEnd,
      required String bio}) async {
    try {
      Map<String, dynamic> body = {
        'jobRoleId': jobRole.id,
        'countries': CountryModel.toIdList(countries),
        'salary-start': salaryStart,
        'salary-end': salaryEnd,
        'bio': bio,
      };
      await datasource.createQueue(data: body);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteQueue({required String queueId}) async {
    try {
      await datasource.deleteQueue(queueId: queueId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
