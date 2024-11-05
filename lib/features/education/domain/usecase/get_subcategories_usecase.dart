import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/education/domain/entity/course_entity.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

class GetSubCategoriesUseCase implements Usecase<List<CourseEntity>, String>{
  final EducationRepository repository;

  GetSubCategoriesUseCase(this.repository);
  @override
  Future<Either<Failure, List<CourseEntity>>> call(String params) async {
    return await repository.getSubCategories(params);
  }
}