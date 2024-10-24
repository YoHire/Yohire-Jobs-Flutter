import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';

class VerifyOtpUsecase implements Usecase<String, OtpVerifyParams> {
  final AuthRepository authRepository;

  VerifyOtpUsecase(this.authRepository);
  @override
  Future<Either<Failure, String>> call(OtpVerifyParams params) async {
    return await authRepository.verifyOtp(
        verificationId: params.verificationId, otp: params.otp);
  }
}

class OtpVerifyParams {
  final String verificationId;
  final String otp;

  OtpVerifyParams({required this.verificationId, required this.otp});
}
