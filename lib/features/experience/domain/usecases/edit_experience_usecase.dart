import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/experience/domain/repository/work_experience_repository.dart';
import 'package:openbn/features/experience/domain/usecases/save_experience_usecase.dart';

class EditExperienceUsecase implements Usecase<void, ExperienceUseCaseParms> {
  final ExperienceRepository repository;

  EditExperienceUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(ExperienceUseCaseParms params) async {
    return await repository.editExperience(
        params.experienceModel, params.certificate);
  }
}

