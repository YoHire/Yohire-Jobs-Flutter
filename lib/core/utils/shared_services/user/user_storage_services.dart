import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/utils/shared_services/user/models/course_model/course_model.dart';
import 'package:openbn/core/utils/shared_services/user/models/education_model/education_model.dart';
import 'package:openbn/core/utils/shared_services/user/models/user_model/user_model.dart';
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

  Future<void> closeBox() async {
    await Hive.box(_boxName).close();
  }
}
