import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/splash/domain/repository/splash_repository.dart';
import 'package:openbn/init_dependencies.dart';

class SplashRepositoryImpl implements SplashRepository {
  @override
  Either<Faliure, bool> checkLoginStatus() {
    try {
      final bool data;
      final storage = serviceLocator<GetStorage>();

      if (storage.read("isLogged") ?? false) {
        data = true;
      } else {
        if (storage.read('firstTime') == null ||
            storage.read('firstTime') == true) {
          data = false;
        } else {
          data = true;
        }
      }
      return Right(data);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }
}
