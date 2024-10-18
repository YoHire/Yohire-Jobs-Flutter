import 'package:openbn/features/prefrences/presentation/models/job_role_model.dart';

abstract class PrefrenceState {}

class PrefrenceInitial extends PrefrenceState {}

class PrefrenceLoading extends PrefrenceState {}

class PrefrenceLoaded extends PrefrenceState {
  final List<JobRoleViewModel> jobRoles;
  final List<JobRoleViewModel> selectedJobRoles;

  PrefrenceLoaded({required this.jobRoles, required this.selectedJobRoles});
}

class SearchedPrefrences extends PrefrenceState {
  final List<JobRoleViewModel> jobRoles;

  SearchedPrefrences({required this.jobRoles});
}

class PrefrenceError extends PrefrenceState {
  final String message;
  PrefrenceError({required this.message});
}

class CreatedGuestUser extends PrefrenceState {}
