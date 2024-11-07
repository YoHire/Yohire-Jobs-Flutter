import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';

abstract class PrefrenceEvent {}

class PrefrenceFetch extends PrefrenceEvent {
  final String industry;
  JobRoleModel? jobRole;
  PrefrenceFetch({this.industry = '',this.jobRole});
}


class SearchJobRoles extends PrefrenceEvent {
  final String keyword;
  SearchJobRoles(this.keyword);
}

class CreateGuestUser extends PrefrenceEvent {
}
