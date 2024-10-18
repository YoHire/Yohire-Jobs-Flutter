import 'package:openbn/features/prefrences/presentation/models/job_role_model.dart';

abstract class PrefrenceEvent {}

class PrefrenceFetch extends PrefrenceEvent {
  final String industry;
  JobRoleViewModel? jobRole;
  PrefrenceFetch({this.industry = '',this.jobRole});
}


class SearchJobRoles extends PrefrenceEvent {
  final String keyword;
  SearchJobRoles(this.keyword);
}

class CreateGuestUser extends PrefrenceEvent {
}
