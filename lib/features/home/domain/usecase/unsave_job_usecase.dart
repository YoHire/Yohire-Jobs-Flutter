import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/home/domain/repository/home_repository.dart';

class UnSaveJobUsecase implements Usecase<void,String>{
  final HomeRepository homeRepository;

  UnSaveJobUsecase(this.homeRepository);

  @override
  Future<Either<Failure, void>> call(String params) async{
    return await homeRepository.unSaveJob(jobId: params);
  }

}