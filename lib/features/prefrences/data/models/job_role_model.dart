import 'package:openbn/features/prefrences/domain/entity/job_role_entity.dart';

class JobRoleModel extends JobRoleEntity {
  JobRoleModel(
      {required super.id, required super.name, required super.industry});

  factory JobRoleModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return JobRoleModel(id: '', name: '', industry: '');
    } else {
      return JobRoleModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        industry: json['industry'] ?? '',
      );
    }
  }

  Map<String, dynamic> toStringList() {
    return {'id': id, 'name': name, 'industry': industry};
  }

  JobRoleEntity toEntity() {
    return JobRoleEntity(id: id, name: name, industry: industry);
  }

  factory JobRoleModel.fromDomain(JobRoleEntity jobRole) {
    return JobRoleModel(
        id: jobRole.id, name: jobRole.name, industry: jobRole.industry);
  }

  // Map<String, dynamic> toIdStringList() {
  //   return {'id': id, 'industry': industry};
  // }
}
