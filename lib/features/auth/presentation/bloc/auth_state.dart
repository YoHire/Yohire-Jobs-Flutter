part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AuthEntity user;

  AuthSuccess({required this.user});
}

final class OtpSent extends AuthState {
  final String countryCode;
  final String number;
  final String verificationId;

  OtpSent(
      {required this.number,
      required this.countryCode,
      required this.verificationId});
}

final class OtpVerified extends AuthState {
  final String idToken;
  final String countryCode;
  final String phone;

  OtpVerified({required this.idToken,required this.countryCode,required this.phone});
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
