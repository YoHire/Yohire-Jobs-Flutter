import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

class DeleteEducationUsecase implements Usecase<void, String> {
  final EducationRepository repository;

  DeleteEducationUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteEducation(params);
  }
}
