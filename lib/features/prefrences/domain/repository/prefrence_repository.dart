import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/prefrences/data/models/job_role_model.dart';
import 'package:openbn/features/prefrences/domain/entity/job_role_entity.dart';

abstract interface class PrefrenceRepository {
  Future<Either<Failure, List<JobRoleEntity>>> getJobRoles({String industry = 'none'});
  Future<Either<Failure, List<JobRoleEntity>>> searchJobRoles({required String keyword});
  Future<Either<Failure, void>> createGuestUser({required List<JobRoleModel> data});
}