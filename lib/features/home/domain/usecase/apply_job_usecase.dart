import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/home/domain/repository/job_repository.dart';

class ApplyJobUsecase implements Usecase<void, JobApplyParams> {
  final JobRepository jobRepository;

  ApplyJobUsecase(this.jobRepository);

  @override
  Future<Either<Failure, void>> call(JobApplyParams params) async {
    return await jobRepository.applyJob(
        recruiterId: params.recruiterId,
        jobId: params.jobId);
  }
}

class JobApplyParams {
  final String jobId;
  final String recruiterId;

  JobApplyParams(
      {required this.jobId, required this.recruiterId});
}
