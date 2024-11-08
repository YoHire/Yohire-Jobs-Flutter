part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class LoadMoreJobs extends HomeEvent {}

class FilterJobsEvent extends HomeEvent {
  final String location;
  final List<SkillModel> skillIds;
  final List<JobRoleModel> jobRolesIds;

  FilterJobsEvent(
      {required this.location,
      required this.skillIds,
      required this.jobRolesIds});
}
class ResetFilter extends HomeEvent {}
