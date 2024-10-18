
import 'package:openbn/features/prefrences/domain/entity/job_role_entity.dart';

class JobRoleViewModel extends JobRoleEntity {
  JobRoleViewModel({
    required super.id,
    required super.name,
    required super.industry,
  });

    JobRoleEntity toDomain() {
    return JobRoleEntity(
      id: id,
      name: name,
      industry: industry
    );
  }
}
