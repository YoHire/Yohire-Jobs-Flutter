import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/utils/shared_services/user/models/course_model/course_model.dart';
part 'education_model.g.dart';

@HiveType(typeId: 1)
class EducationModel {
  @HiveField(0)
  final String? id;

  @HiveField(2)
  final String institution;

  @HiveField(3)
  final String? courseId;

  @HiveField(4)
  final CourseModel? courseData;

  @HiveField(5)
  final DateTime dateOfCompletion;

  @HiveField(6)
  String certificateUrl;

  @HiveField(7)
  String level;

  @HiveField(8)
  final String userId;
  EducationModel(
      {required this.institution,
      required this.dateOfCompletion,
      this.id,
      this.courseData,
      this.courseId,
      required this.userId,
      required this.certificateUrl,
      required this.level});

  Map<String, dynamic> toJson() {
    return {
      'institution': institution.trim(),
      'completedDate': dateOfCompletion.toIso8601String(),
      'certificate': certificateUrl,
      'level': level,
      'courseId': courseId,
    };
  }

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'],
      institution: json['institution'],
      dateOfCompletion: DateTime.parse(json['completedDate']),
      userId: json['userId'],
      certificateUrl: json['certificate'] ?? '',
      level: json['level'] ?? '',
      courseData: json['qualifications'] == null
          ? CourseModel(id: '', course: '', category: '', subCategory: '')
          : json['qualifications'].isEmpty
              ? CourseModel(id: '', course: '', category: '', subCategory: '')
              : CourseModel.fromJson(json['qualifications'][0])
    );
  }
}
