import 'package:hive_flutter/hive_flutter.dart';
part 'job_role_model.g.dart';

@HiveType(typeId: 4)
class JobRoleModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? industry;

  JobRoleModel({
    required this.id,
    required this.name,
    required this.industry,
  });

  // JSON serialization
  factory JobRoleModel.fromJson(Map<String, dynamic> json) {
    return JobRoleModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      industry: json['industry'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'industry': industry,
    };
  }

  Map<String, dynamic> toStringList() {
    return {'id': id, 'name': name, 'industry': industry};
  }
}
