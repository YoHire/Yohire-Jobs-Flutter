import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';

abstract interface class SplashRepository {
  Either<Faliure, bool> checkLoginStatus();
}
