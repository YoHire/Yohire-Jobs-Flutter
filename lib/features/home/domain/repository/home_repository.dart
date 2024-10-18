import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Faliure, List<JobEntity>>> getAllJobs();
}
