import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/course/course_model.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

class GetCategoriesUseCase implements Usecase<List<CourseModel>, void>{
  final EducationRepository repository;

  GetCategoriesUseCase(this.repository);
  @override
  Future<Either<Failure, List<CourseModel>>> call(params) async {
    return await repository.getCategories();
  }
}