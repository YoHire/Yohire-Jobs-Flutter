import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/auth/domain/entity/auth_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthEntity>> signIn();
  Future<Either<Failure, bool>> checkPhone({required String phone});
  Future<Either<Failure, String>> sendOtp(
      {required String phoneWithCountryCode});
  Future<Either<Failure, String>> verifyOtp(
      {required String verificationId, required String otp});
  //user creation process will happen with this function
  Future<Either<Failure, AuthEntity>> verifyPhone(
      {required String idToken,
      required String phone,
      required String countryCode});
}
