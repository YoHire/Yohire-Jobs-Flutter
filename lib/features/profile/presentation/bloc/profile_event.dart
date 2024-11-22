part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}
class EmitBlocDocumentSuccess extends ProfileEvent {}

class UpdatePersonalDataEvent extends ProfileEvent {
  final PersonalDetailsEntity data;

  UpdatePersonalDataEvent({required this.data});
}

class UpdateSkillEvent extends ProfileEvent {
  final List<SkillModel> data;

  UpdateSkillEvent({required this.data});
}

class UpdateJobPrefs extends ProfileEvent {
  final List<JobRoleModel> data;

  UpdateJobPrefs({required this.data});
}

class UpdateLanguageReadwrite extends ProfileEvent {
  final List<LanguageModel> data;

  UpdateLanguageReadwrite({required this.data});
}



class UpdateLanguageSpeak extends ProfileEvent {
  final List<LanguageModel> data;

  UpdateLanguageSpeak({required this.data});
}

class GetSavedJobs extends ProfileEvent {}
class GetAppliedJobs extends ProfileEvent {}

class UpdateDocument extends ProfileEvent {
  final DocumentModel data;
  final File file;
  final ValueNotifier<double> progressTracker;

  UpdateDocument({required this.data, required this.file, required this.progressTracker});


}
