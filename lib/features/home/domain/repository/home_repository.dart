import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<JobEntity>>> getAllJobs();
  Future<Either<Failure, List<JobEntity>>> getMoreJobs({required int skip});
  Future<Either<Failure, List<JobEntity>>> getFilteredJobs(
      {required String location,
      required List<SkillModel> skillIds,
      required List<JobRoleModel> jobRoleIds});
  Future<Either<Failure, void>> saveJob({required String jobId});
  Future<Either<Failure, void>> unSaveJob({required String jobId});
}
