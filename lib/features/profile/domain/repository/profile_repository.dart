import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/home/data/models/job_model.dart';
import 'package:openbn/features/profile/data/models/personal_details_model.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, void>> updatePersonalDetails(
      {required PersonalDetailsModel personalDetails});
  Future<Either<Failure, void>> updateSkills(
      {required List<SkillModel> skillIds});
  Future<Either<Failure, void>> updateJobPrefs(
      {required List<JobRoleModel> jobRoleIds});
}
