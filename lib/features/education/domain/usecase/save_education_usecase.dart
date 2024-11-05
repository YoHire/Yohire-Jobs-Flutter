import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/education/domain/entity/education_entity.dart';
import 'package:openbn/features/education/domain/repository/education_repository.dart';

class SaveEducationUsecase implements Usecase<void, EducationUseCaseParms> {
  final EducationRepository repository;

  SaveEducationUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(EducationUseCaseParms params) async {
    return await repository.saveEducation(
        params.educationEntity.toData(), params.certificate);
  }
}

class EducationUseCaseParms {
  final EducationEntity educationEntity;
  File? certificate;

  EducationUseCaseParms({required this.educationEntity, this.certificate});
}
