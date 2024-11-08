part of 'job_bloc.dart';

sealed class JobState {}

final class JobInitial extends JobState {}

final class JobLoading extends JobState {}

final class JobApplying extends JobState {}

final class JobApplied extends JobState {}

final class JobLoaded extends JobState {
  final JobEntity data;

  JobLoaded({required this.data});
}

final class JobError extends JobState {
  final String message;

  JobError({required this.message});
}
