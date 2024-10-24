import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';

abstract interface class UsernameRepository {
  Future<Either<Failure, void>> saveUsername({required String username});
}