import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/profile/domain/entity/applied_job_entity.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';

class GetAppliedJobsUsecase implements Usecase<List<AppliedJobEntity>, void> {
  final ProfileRepository profileRepository;

  GetAppliedJobsUsecase(this.profileRepository);
  @override
  Future<Either<Failure, List<AppliedJobEntity>>> call(params) async {
    return await profileRepository.getAppliedJobs();
  }
}
