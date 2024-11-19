import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/firebase_storage/firebase_storage.dart';
import 'package:openbn/core/utils/shared_services/functions/date_services.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/features/profile/data/datasource/profile_datasource.dart';
import 'package:openbn/features/profile/data/models/personal_details_model.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';
import 'package:openbn/init_dependencies.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, void>> updatePersonalDetails(
      {required PersonalDetailsModel personalDetails}) async {
    final firebaseStorage = serviceLocator<FileUploadService>();
    final getStorage = serviceLocator<GetStorage>();
    final UserStorageService localStorage =
        serviceLocator<UserStorageService>();
    String? profileUrl = localStorage.getUser()!.profileImage ?? '';
    try {
      if (personalDetails.profileImage != null) {
        profileUrl = await firebaseStorage.uploadFile(
            file: personalDetails.profileImage!,
            fileAnnotation: FileAnnotations.PROFILE_PICTURE,
            folderName: getStorage.read('userId'));
      }
      Map<String, dynamic> body = {
        "username": personalDetails.username,
        "surname": personalDetails.surname,
        "address": personalDetails.address,
        "dateOfBirth":
            DateServices.convertDateFormat(personalDetails.dateOfBirth),
        "height": personalDetails.height,
        "weight": personalDetails.weight,
        "maritialStatus": '',
        "gender": personalDetails.gender,
        "profileImage": profileUrl,
        "bio": personalDetails.bio,
      };
      await datasource.savePersonalDetails(body: body);
      await serviceLocator<UserStorageService>().updateUser();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSkills(
      {required List<SkillModel> skillIds}) async {
    try {
      Map<String, dynamic> body = {
        'skills': skillIds.map((e) => SkillModel.getId(e)).toList()
      };
      await datasource.updateSkills(body: body);
      await serviceLocator<UserStorageService>().updateUser();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateJobPrefs(
      {required List<JobRoleModel> jobRoleIds}) async {
    try {
      Map<String, dynamic> body = {
        'categories': jobRoleIds.map((e) => JobRoleModel.getId(e)).toList()
      };
      await datasource.updateJobPrefs(body: body);
      await serviceLocator<UserStorageService>().updateUser();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
