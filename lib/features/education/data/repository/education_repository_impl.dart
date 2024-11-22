import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/firebase_storage/firebase_storage.dart';
import 'package:openbn/core/utils/shared_services/models/course/course_model.dart';
import 'package:openbn/core/utils/shared_services/models/education/education_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/features/education/data/datasource/education_remote_datasource.dart';

import 'package:openbn/features/education/domain/repository/education_repository.dart';
import 'package:openbn/init_dependencies.dart';

class EducationRepositoryImpl implements EducationRepository {
  final EducationRemoteDataSource remoteDataSource;

  EducationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CourseModel>>> getCategories() async {
    try {
      final data = await remoteDataSource.getCategories();
      final results = data['data'] as List<dynamic>;

      final courses = results
          .map((json) => CourseModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(courses);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseModel>>> getSubCategories(
      String category) async {
    try {
      final data = await remoteDataSource.getSubCategories(category);
      final results = data['data'] as List<dynamic>;

      final courses = results
          .map((json) => CourseModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(courses);
    } catch (e) {
      throw Exception('Failed to fetch sub categories');
    }
  }

  @override
  Future<Either<Failure, List<CourseModel>>> getCourses(
      String category, String? subCategory) async {
    try {
      final data = await remoteDataSource.getCourses(category, subCategory);
      final results = data['data'] as List<dynamic>;

      final courses = results
          .map((json) => CourseModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(courses);
    } catch (e) {
      throw Exception('Failed to fetch courses');
    }
  }

  @override
  Future<Either<Failure, void>> saveEducation(
      EducationModel eduData, File? certificate) async {
    try {
      final firebaseStorage = serviceLocator<FileUploadService>();
      final getStorage = serviceLocator<GetStorage>();
      final userStorage = serviceLocator<UserStorageService>();
      String? certificateUrl = '';
      if (certificate != null) {
        certificateUrl = await firebaseStorage.uploadFile(
            file: certificate,
            fileAnnotation: FileAnnotations.EDUCATION_CERTIFICATE,
            folderName: getStorage.read('userId'));
      }
      Map<String, dynamic> data = {
        'institution': eduData.institution,
        'courseId': eduData.courseData!.id,
        'completedDate': '${eduData.dateOfCompletion.toIso8601String()}Z',
        'certificate': certificateUrl,
      };
      await remoteDataSource.saveEducation(data);
      await userStorage.updateUser();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEducation(
      EducationModel eduData, File? certificate) async {
    try {
      final firebaseStorage = serviceLocator<FileUploadService>();
      final getStorage = serviceLocator<GetStorage>();
      final userStorage = serviceLocator<UserStorageService>();
      String? certificateUrl = '';
      if (certificate != null) {
        certificateUrl = await firebaseStorage.uploadFile(
            file: certificate,
            fileAnnotation: FileAnnotations.EDUCATION_CERTIFICATE,
            folderName: getStorage.read('userId'));
      }
      if (certificateUrl == null || certificateUrl.isEmpty) {
        certificateUrl = eduData.certificateUrl;
      }

      Map<String, dynamic> data = {
        'id': eduData.id,
        'institution': eduData.institution,
        'courseId': eduData.courseData!.id,
        'completedDate': '${eduData.dateOfCompletion.toIso8601String()}Z',
        'certificate': certificateUrl,
      };
      await remoteDataSource.updateEducation(data);
      await userStorage.updateUser();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEducation(String id) async {
    try {
      final userStorage = serviceLocator<UserStorageService>();
      await remoteDataSource.deleteEducation(id);
      await userStorage.updateUser();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
