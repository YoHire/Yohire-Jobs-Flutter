import 'package:openbn/features/education/domain/entity/education_entity.dart';

class EducationModel extends EducationEntity {
  EducationModel(
      {required super.id,
      required super.course,
      required super.completionDate,
      required super.certificateUrl, required super.institution});
}
