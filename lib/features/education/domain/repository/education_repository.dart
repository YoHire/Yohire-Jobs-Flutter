import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/education/domain/entity/course_entity.dart';

import '../../data/models/education_model.dart';

abstract class EducationRepository {
  Future<Either<Failure, List<CourseEntity>>> getCategories();
  Future<Either<Failure, List<CourseEntity>>> getSubCategories(String category);
  Future<Either<Failure, List<CourseEntity>>> getCourses(String category, String? subCategory);
  Future<Either<Failure, void>> saveEducation(EducationModel data,File? certificate);
}
