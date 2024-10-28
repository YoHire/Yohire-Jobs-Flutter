import 'package:hive/hive.dart';
 part 'course_model.g.dart';
 
@HiveType(typeId: 2)
class CourseModel {
  @HiveField(1)
  final String id;

  @HiveField(2)
  final String course;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String subCategory;

  CourseModel(
      {required this.id,
      required this.course,
      required this.category,
      required this.subCategory});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        id: json['id'],
        course: json['course'],
        category: json['category'],
        subCategory: json['subCategory'] ?? '');
  }

  static String toStringList(CourseModel data) {
    return data.course;
  }
}
