import 'package:hive_flutter/hive_flutter.dart';
part 'skill_model.g.dart';

@HiveType(typeId: 5)
class SkillModel {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  SkillModel({
    required this.id,
    required this.name,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  factory SkillModel.getName(Map<String, dynamic> json) {
    return json['name'];
  }

  String toStringList() {
    return id;
  }

}
