part of 'queue_bloc.dart';

sealed class QueueEvent {}

class QueueInitEvent extends QueueEvent {}

class SelectJobRole extends QueueEvent {
  final JobRoleModel jobRole;

  SelectJobRole({required this.jobRole});
}

class SelectCountry extends QueueEvent {
  final CountryModel country;

  SelectCountry({required this.country});
}

class SelectAllCountry extends QueueEvent {}

class DeSelectAllCountry extends QueueEvent {}

class SetSalaryRange extends QueueEvent {
  final double startingSalary;
  final double endingSalary;

  SetSalaryRange({required this.startingSalary, required this.endingSalary});
}

class JoinQueue extends QueueEvent {
  final String bio;

  JoinQueue({required this.bio});
  
}
