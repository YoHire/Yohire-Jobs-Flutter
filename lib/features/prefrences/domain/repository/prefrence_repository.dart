import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';

abstract interface class PrefrenceRepository {
  Future<Either<Failure, List<JobRoleModel>>> getJobRoles({String industry = 'none'});
  Future<Either<Failure, List<JobRoleModel>>> searchJobRoles({required String keyword});
  Future<Either<Failure, void>> createGuestUser({required List<JobRoleModel> data});
}