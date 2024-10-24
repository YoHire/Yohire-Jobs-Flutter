import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';

class SentOtpUsecase implements Usecase<String, String> {
  final AuthRepository authRepository;

  SentOtpUsecase(this.authRepository);
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await authRepository.sendOtp(phoneWithCountryCode: params);
  }
}
