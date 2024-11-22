part of 'experience_bloc.dart';

sealed class ExperienceEvent {}

class SaveExperience extends ExperienceEvent {
  final WorkExperienceModel data;
  File? file;
  SaveExperience({required this.data, this.file});
}

class DeleteExperience extends ExperienceEvent {
  final String id;
  DeleteExperience({required this.id});
}
