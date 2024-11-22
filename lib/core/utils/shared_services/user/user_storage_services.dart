import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/course/course_model.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/core/utils/shared_services/models/education/education_model.dart';
import 'package:openbn/core/utils/shared_services/models/experience/workexperience_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/core/utils/shared_services/models/user/user_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_api_services.dart';
import 'package:openbn/init_dependencies.dart';

class UserStorageService {
  static const String _boxName = 'userBox';
  static const String _userKey = 'current_user';
  final userApi = serviceLocator<UserApiServices>();
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(EducationModelAdapter());
    Hive.registerAdapter(CourseModelAdapter());
    Hive.registerAdapter(WorkExperienceModelAdapter());
    Hive.registerAdapter(JobRoleModelAdapter());
    Hive.registerAdapter(SkillModelAdapter());
    Hive.registerAdapter(LanguageModelAdapter());
    Hive.registerAdapter(CountryModelAdapter());
    Hive.registerAdapter(DocumentModelAdapter());
    await Hive.openBox<UserModel>(_boxName);
  }

  Future<void> saveUser(UserModel user) async {
    try {
      final box = Hive.box<UserModel>(_boxName);
      await box.put(_userKey, user);
    } catch (e) {
      log('ERROR IN SAVING USER ${e.toString()}');
    }
  }

  Future<void> updateUser() async {
    try {
      UserModel? data = await userApi.getUser();
      if (data != null) {
        final box = Hive.box<UserModel>(_boxName);
        await box.put(_userKey, data);
      }
    } catch (e) {
      log('ERROR IN SAVING USER ${e.toString()}');
    }
  }

  UserModel? getUser() {
    final box = Hive.box<UserModel>(_boxName);
    return box.get(_userKey);
  }

  Future<void> deleteUser() async {
    final box = Hive.box<UserModel>(_boxName);
    await box.delete(_userKey);
  }

  bool get hasUser {
    final box = Hive.box<UserModel>(_boxName);
    return box.containsKey(_userKey);
  }

  bool checkCompleted() {
    final box = Hive.box<UserModel>(_boxName);
    final user = box.get(_userKey);
    if (user == null) return false;

    bool isProfileComplete = _isFieldComplete(user.address) &&
        _isFieldComplete(user.username) &&
        _isFieldComplete(user.surname) &&
        _isFieldComplete(user.bio) &&
        _isFieldComplete(user.height) &&
        _isFieldComplete(user.weight) &&
        _isFieldComplete(user.gender) &&
        _isFieldComplete(user.dateOfBirth.toString());

    return isProfileComplete &&
        user.education.isNotEmpty &&
        user.experience.isNotEmpty &&
        user.skills.isNotEmpty &&
        user.prefrences.isNotEmpty &&
        user.languagesReadAndWrite.isNotEmpty &&
        user.languagesSpeak.isNotEmpty &&
        user.documents.isNotEmpty;
    // return true;
  }

  List<ProfileStatus> checkCompletionStatus() {
    final box = Hive.box<UserModel>(_boxName);
    final user = box.get(_userKey);
    if (user == null) return [ProfileStatus.Incomplete];

    List<ProfileStatus> retList = [];

    bool isProfileComplete = _isFieldComplete(user.address) &&
        _isFieldComplete(user.username) &&
        _isFieldComplete(user.surname) &&
        _isFieldComplete(user.bio) &&
        _isFieldComplete(user.height) &&
        _isFieldComplete(user.weight) &&
        _isFieldComplete(user.gender) &&
        _isFieldComplete(user.dateOfBirth.toString());

    retList.add(
        isProfileComplete ? ProfileStatus.Completed : ProfileStatus.Incomplete);

    retList.add(user.education.isNotEmpty
        ? ProfileStatus.Completed
        : ProfileStatus.Incomplete);

    retList.add(user.experience.isNotEmpty
        ? ProfileStatus.Completed
        : ProfileStatus.Warning);
    retList.add(user.skills.isNotEmpty && user.prefrences.isNotEmpty
        ? ProfileStatus.Completed
        : ProfileStatus.Warning);
    retList.add(
        user.languagesSpeak.isNotEmpty && user.languagesReadAndWrite.isNotEmpty
            ? ProfileStatus.Completed
            : ProfileStatus.Warning);
    retList.add(user.resume != null && user.resume!.isNotEmpty
        ? ProfileStatus.Completed
        : ProfileStatus.Incomplete);

    return retList;
  }

  bool _isFieldComplete(String? field) {
    return field != null && field.isNotEmpty;
  }

  Future<void> closeBox() async {
    await Hive.box(_boxName).close();
  }
}
