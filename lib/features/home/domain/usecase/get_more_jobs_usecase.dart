import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/repository/home_repository.dart';

class GetMoreJobsUsecase implements Usecase<List<JobEntity>,int>{
  final HomeRepository homeRepository;

  GetMoreJobsUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<JobEntity>>> call(int params) async{
    return await homeRepository.getMoreJobs(skip: params);
  }

}