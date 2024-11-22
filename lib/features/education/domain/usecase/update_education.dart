import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

import 'save_education_usecase.dart';

class UpdateEducationUsecase implements Usecase<void, EducationUseCaseParms> {
  final EducationRepository repository;

  UpdateEducationUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(EducationUseCaseParms params) async {
    return await repository.updateEducation(
        params.educationModel, params.certificate);
  }
}


