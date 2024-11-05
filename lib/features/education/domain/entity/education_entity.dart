import 'package:openbn/features/education/data/models/education_model.dart';
import 'package:openbn/features/education/domain/entity/course_entity.dart';

class EducationEntity {
  final String id;
  final String institution;
  final CourseEntity course;
  final DateTime completionDate;
  final String certificateUrl;

  EducationEntity(
      {required this.id,
      required this.institution,
      required this.course,
      required this.completionDate,
      required this.certificateUrl,});

          EducationModel toData() {
    return EducationModel(
      id: id,
      institution: institution,
      course: course,
      completionDate: completionDate,
      certificateUrl: certificateUrl
    );
  }
}
