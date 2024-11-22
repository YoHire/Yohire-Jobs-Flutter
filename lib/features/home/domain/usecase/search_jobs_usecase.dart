import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/repository/home_repository.dart';

class SearchJobsUsecase implements Usecase<List<JobEntity>, String> {
  final HomeRepository homeRepository;

  SearchJobsUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<JobEntity>>> call(String params) async {
    return await homeRepository.getSearchedJobs(keyword: params);
  }
}
