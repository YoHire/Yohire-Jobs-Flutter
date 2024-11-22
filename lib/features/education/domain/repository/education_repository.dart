import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/course/course_model.dart';
import 'package:openbn/core/utils/shared_services/models/education/education_model.dart';


abstract class EducationRepository {
  Future<Either<Failure, List<CourseModel>>> getCategories();
  Future<Either<Failure, List<CourseModel>>> getSubCategories(String category);
  Future<Either<Failure, List<CourseModel>>> getCourses(String category, String? subCategory);
  Future<Either<Failure, void>> saveEducation(EducationModel data,File? certificate);
  Future<Either<Failure, void>> updateEducation(EducationModel data,File? certificate);
  Future<Either<Failure, void>> deleteEducation(String id);
}
