part of 'profile_bloc.dart';

sealed class ProfileEvent{}

class UpdatePersonalDataEvent extends ProfileEvent{
  final PersonalDetailsEntity data;

  UpdatePersonalDataEvent({required this.data});
}
class UpdateSkillEvent extends ProfileEvent{
  final List<SkillModel> data;

  UpdateSkillEvent({required this.data});
}
class UpdateJobPrefs extends ProfileEvent{
  final List<JobRoleModel> data;

  UpdateJobPrefs({required this.data});
}
