import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/education/domain/entity/course_entity.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

class GetCategoriesUseCase implements Usecase<List<CourseEntity>, void>{
  final EducationRepository repository;

  GetCategoriesUseCase(this.repository);
  @override
  Future<Either<Failure, List<CourseEntity>>> call(params) async {
    return await repository.getCategories();
  }
}