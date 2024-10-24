
import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/splash/domain/repository/splash_repository.dart';

class SplashUsecase implements Usecase<bool,dynamic>{
  final SplashRepository splashRepository;

  SplashUsecase(this.splashRepository);
  @override
  Future<Either<Failure, bool>> call(params) async{
    return splashRepository.checkLoginStatus();
  }

}