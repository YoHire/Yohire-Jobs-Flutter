import 'package:openbn/features/prefrences/data/models/job_role_model.dart';

class JobRoleEntity {
  final String id;
  final String? name;
  final String? industry;

  JobRoleEntity({required this.id,required this.name,required this.industry});

    JobRoleModel toData() {
    return JobRoleModel(
      id: id,
      name: name,
      industry: industry
    );
  }
}
