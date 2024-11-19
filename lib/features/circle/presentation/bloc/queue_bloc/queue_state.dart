part of 'queue_bloc.dart';

sealed class QueueState {}

final class QueueInitial extends QueueState {}

final class QueueLoading extends QueueState {}

final class QueueError extends QueueState {
  final String error;

  QueueError({required this.error});
}

final class QueueLoaded extends QueueState {
  final JobRoleModel jobRole;
  final List<CountryModel> countries;
  final double salaryStart;
  final double salaryEnd;

  QueueLoaded(
      {required this.jobRole,
      required this.countries,
      required this.salaryStart,
      required this.salaryEnd});
}

final class QueueJoining extends QueueState {}

class QueueJoined extends QueueState {}
