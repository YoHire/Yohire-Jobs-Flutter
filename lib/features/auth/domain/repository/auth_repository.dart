import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/auth/domain/entity/auth_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Faliure, AuthEntity>> signIn();
}
