part of 'username_bloc.dart';

sealed class UsernameEvent {}

class SaveUserName extends UsernameEvent {
  final String username;

  SaveUserName({required this.username});
}
