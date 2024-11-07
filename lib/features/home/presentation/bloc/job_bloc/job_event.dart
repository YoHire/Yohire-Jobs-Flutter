part of 'job_bloc.dart';

sealed class JobEvent {}

class JobInitEvent extends JobEvent {
  final String id;

  JobInitEvent({required this.id});
}

class JobApplyEvent extends JobEvent {
  final String jobId;
  final String recruiterId;

  JobApplyEvent(
      {required this.jobId, required this.recruiterId});
}
