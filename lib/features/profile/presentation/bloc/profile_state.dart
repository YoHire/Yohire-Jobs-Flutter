part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileUpdating extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class UpdateSuccess extends ProfileState {}
final class SkillUpdateSuccess extends ProfileState {}
final class JobPrefUpdateSuccess extends ProfileState {}
final class UpdateError extends ProfileState {
  final String message;

  UpdateError({required this.message });
}
