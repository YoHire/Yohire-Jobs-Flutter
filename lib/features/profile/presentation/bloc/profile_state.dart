part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileUpdating extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class UpdateSuccess extends ProfileState {}

final class SkillUpdateSuccess extends ProfileState {}

final class JobPrefUpdateSuccess extends ProfileState {}

final class LanguageReadWriteUpdateSuccess extends ProfileState {}

final class LanguageSpeakUpdateSuccess extends ProfileState {}

final class DocumentUpdateSuccess extends ProfileState {}

final class DocumentUploading extends ProfileState {}

final class SavedJobsLoaded extends ProfileState {
  final List<SavedJobEntity> jobs;

  SavedJobsLoaded({required this.jobs});
}

final class AppliedJobsLoaded extends ProfileState {
  final List<AppliedJobEntity> jobs;

  AppliedJobsLoaded({required this.jobs});
}

final class AppliedJobsEmpty extends ProfileState {}

final class SavedJobsEmpty extends ProfileState {}

final class UpdateError extends ProfileState {
  final String message;

  UpdateError({required this.message});
}
