import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';

abstract interface class JobRepository {
  Future<Either<Failure, JobEntity>> getJobById({required String id});
  Future<Either<Failure, void>> applyJob({required String recruiterId,required String jobId});
}
