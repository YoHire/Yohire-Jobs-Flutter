import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/experience/workexperience_model.dart';

abstract class ExperienceRepository {
  Future<Either<Failure, void>> saveExperience(
      WorkExperienceModel data, File? certificate);
  Future<Either<Failure, void>> editExperience(WorkExperienceModel data);
  Future<Either<Failure, void>> deleteExperience(String experienceId);
}
