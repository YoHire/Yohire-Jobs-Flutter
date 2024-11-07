import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/course/course_model.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

class GetSubCategoriesUseCase implements Usecase<List<CourseModel>, String>{
  final EducationRepository repository;

  GetSubCategoriesUseCase(this.repository);
  @override
  Future<Either<Failure, List<CourseModel>>> call(String params) async {
    return await repository.getSubCategories(params);
  }
}