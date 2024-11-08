import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/repository/home_repository.dart';

class FilterJobsUsecase implements Usecase<List<JobEntity>, FilterJobParams> {
  final HomeRepository homeRepository;

  FilterJobsUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<JobEntity>>> call(FilterJobParams params) async {
    return await homeRepository.getFilteredJobs(
        location: params.location,
        skillIds: params.skillIds,
        jobRoleIds: params.jobRoleIds);
  }
}

class FilterJobParams {
  final List<SkillModel> skillIds;
  final List<JobRoleModel> jobRoleIds;
  final String location;

  FilterJobParams(
      {required this.skillIds,
      required this.jobRoleIds,
      required this.location});
}
