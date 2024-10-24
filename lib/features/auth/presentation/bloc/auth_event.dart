part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthInit extends AuthEvent {}
class CheckPhoneNumber extends AuthEvent {
  final String countryCode;
  final String phoneNumber;

  CheckPhoneNumber({required this.phoneNumber,required this.countryCode});
}

class VerifyOtp extends AuthEvent {
  final String verificationId;
  final String otp;
    final String phone;
  final String countryCode;

  VerifyOtp({required this.otp,required this.verificationId,required this.phone,required this.countryCode });
}

class CreateUser extends AuthEvent {
  final String idToken;
  final String phone;
  final String countryCode;

  CreateUser({required this.phone,required this.idToken,required this.countryCode});
}

