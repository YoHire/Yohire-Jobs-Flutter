import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/firebase_storage/firebase_storage.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/features/experience/data/datasource/experience_remote_datasource.dart';
import 'package:openbn/features/experience/domain/repository/work_experience_repository.dart';
import 'package:openbn/init_dependencies.dart';

import '../../../../core/utils/shared_services/models/experience/workexperience_model.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceRemoteDatasource remoteDataSource;

  ExperienceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> saveExperience(
      WorkExperienceModel data, File? certificate) async {
    try {
      final firebaseStorage = serviceLocator<FileUploadService>();
      final getStorage = serviceLocator<GetStorage>();
      final userStorage = serviceLocator<UserStorageService>();
      String? certificateUrl;

      if (certificate != null) {
        certificateUrl = await firebaseStorage.uploadFile(
            file: certificate,
            fileAnnotation: FileAnnotations.EXPERIENCE_CERTIFICATE,
            folderName: getStorage.read('userId'));
      }

      final Map<String, dynamic> experienceData = {
        'companyName': data.company,
        'startDate': '${data.startDate}Z',
        'endDate': data.endDate != null ? '${data.endDate}Z' : null,
        'jobRoleId': data.designation!.id,
        'certificate': certificateUrl,
      };

      await remoteDataSource.saveExperience(experienceData);
      await userStorage.updateUser();

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExperience(String experienceId) async {
    try {
      final userStorage = serviceLocator<UserStorageService>();

      await remoteDataSource.deleteExperience(experienceId);
      await userStorage.updateUser();

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editExperience(
      WorkExperienceModel data, File? certificate) async {
    try {
      final firebaseStorage = serviceLocator<FileUploadService>();
      final getStorage = serviceLocator<GetStorage>();
      final userStorage = serviceLocator<UserStorageService>();
      String? certificateUrl;

      if (certificate != null) {
        certificateUrl = await firebaseStorage.uploadFile(
            file: certificate,
            fileAnnotation: FileAnnotations.EXPERIENCE_CERTIFICATE,
            folderName: getStorage.read('userId'));
      }

      if (certificateUrl == null || certificateUrl.isEmpty) {
        certificateUrl = data.certificateUrl;
      }

      final Map<String, dynamic> experienceData = {
        'id':data.id,
        'companyName': data.company,
        'startDate': '${data.startDate}Z',
        'endDate': data.endDate != null ? '${data.endDate}Z' : null,
        'jobRoleId': data.designation!.id,
        'certificate': certificateUrl,
      };

      await remoteDataSource.editExperience(experienceData);
      await userStorage.updateUser();

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
