import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/repository/job_repository.dart';

class GetSingleJobUsecase implements Usecase<JobEntity,String>{
  final JobRepository homeRepository;

  GetSingleJobUsecase(this.homeRepository);

  @override
  Future<Either<Failure, JobEntity>> call(String params) async{
    return await homeRepository.getJobById(id: params);
  }

}