import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/experience/workexperience_model.dart';
import 'package:openbn/features/experience/domain/repository/work_experience_repository.dart';

class SaveExperienceUsecase implements Usecase<void, ExperienceUseCaseParms> {
  final ExperienceRepository repository;

  SaveExperienceUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(ExperienceUseCaseParms params) async {
    return await repository.saveExperience(
        params.experienceModel, params.certificate);
  }
}

class ExperienceUseCaseParms {
  final WorkExperienceModel experienceModel;
  File? certificate;

  ExperienceUseCaseParms({required this.experienceModel, this.certificate});
}
