import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/auth/domain/entity/auth_entity.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';

class CreateUserUsecase implements Usecase<AuthEntity, CreateUserParams> {
  final AuthRepository authRepository;

  CreateUserUsecase(this.authRepository);
  @override
  Future<Either<Failure, AuthEntity>> call(CreateUserParams params) async {
    return await authRepository.verifyPhone(
        countryCode: params.countryCode,
        phone: params.phone,
        idToken: params.idToken);
  }
}

class CreateUserParams {
  final String countryCode;
  final String idToken;
  final String phone;

  CreateUserParams(
      {required this.countryCode, required this.idToken, required this.phone});
}
