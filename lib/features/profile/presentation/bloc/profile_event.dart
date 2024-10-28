part of 'profile_bloc.dart';

sealed class ProfileEvent{}

class UpdatePersonalDataEvent extends ProfileEvent{
  final PersonalDetailsEntity data;

  UpdatePersonalDataEvent({required this.data});
}
