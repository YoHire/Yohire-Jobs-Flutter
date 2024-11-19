import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';

class UpdateJobprefUsecase implements Usecase<void, List<JobRoleModel>> {
  final ProfileRepository profileRepository;

  UpdateJobprefUsecase(this.profileRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await profileRepository.updateJobPrefs(jobRoleIds: params);
  }
}
