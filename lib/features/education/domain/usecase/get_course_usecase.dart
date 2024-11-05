import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/education/domain/entity/course_entity.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

class GetCoursesUseCase
    implements Usecase<List<CourseEntity>, GetCourseUsecaseParams> {
  final EducationRepository repository;

  GetCoursesUseCase(this.repository);
  @override
  Future<Either<Failure, List<CourseEntity>>> call(
      GetCourseUsecaseParams params) async {
    return await repository.getCourses(params.category, params.subCategory);
  }
}

class GetCourseUsecaseParams {
  final String category;
  final String subCategory;

  GetCourseUsecaseParams({
    required this.category,
    required this.subCategory,
  });
}
