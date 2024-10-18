part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AuthEntity user;

  AuthSuccess({required this.user});
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
