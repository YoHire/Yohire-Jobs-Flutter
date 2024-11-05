import 'package:openbn/features/education/domain/entity/course_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel(
      {required super.id,
      required super.course,
      required super.category,
      required super.subCategory});
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      course: json['course'],
      category: json['category'],
      subCategory: json['subCategory'],
    );
  }
}
