import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/profile/domain/entity/saved_job_entity.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';

class GetSavedJobsUsecase implements Usecase<List<SavedJobEntity>, void> {
  final ProfileRepository profileRepository;

  GetSavedJobsUsecase(this.profileRepository);
  @override
  Future<Either<Failure, List<SavedJobEntity>>> call(params) async {
    return await profileRepository.getSavedJobs();
  }
}
