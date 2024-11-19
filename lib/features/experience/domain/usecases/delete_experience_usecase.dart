import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/experience/domain/repository/work_experience_repository.dart';

class DeleteExperienceUsecase implements Usecase<void, String> {
  final ExperienceRepository repository;

  DeleteExperienceUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteExperience(params);
  }
}