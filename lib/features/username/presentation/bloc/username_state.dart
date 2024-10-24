part of 'username_bloc.dart';

sealed class UsernameState {}

final class UsernameInitial extends UsernameState {}

final class UsernameLoading extends UsernameState {}

final class UsernameSaved extends UsernameState {}

final class UsernameError extends UsernameState {
  final String errorMessage;

   UsernameError({required this.errorMessage});
}
