import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';

abstract class PrefrenceState {}

class PrefrenceInitial extends PrefrenceState {}

class PrefrenceLoading extends PrefrenceState {}

class PrefrenceLoaded extends PrefrenceState {
  final List<JobRoleModel> jobRoles;
  final List<JobRoleModel> selectedJobRoles;

  PrefrenceLoaded({required this.jobRoles, required this.selectedJobRoles});
}

class SearchedPrefrences extends PrefrenceState {
  final List<JobRoleModel> jobRoles;

  SearchedPrefrences({required this.jobRoles});
}

class PrefrenceError extends PrefrenceState {
  final String message;
  PrefrenceError({required this.message});
}

class CreatedGuestUser extends PrefrenceState {}
