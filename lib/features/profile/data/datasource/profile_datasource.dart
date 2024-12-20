import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

abstract interface class ProfileDatasource {
  Future<dynamic> savePersonalDetails({required Map<String, dynamic> body});
  Future<dynamic> updateSkills({required Map<String, dynamic> body});
  Future<dynamic> updateJobPrefs({required Map<String, dynamic> body});
  Future<dynamic> updateLanguagesReadAndWrite(
      {required Map<String, dynamic> body});
  Future<dynamic> updateLanguagesSpeak({required Map<String, dynamic> body});
  Future<dynamic> updateDocument({required Map<String, dynamic> body});
  Future<dynamic> getSavedJobs();
  Future<dynamic> getAppliedJobs();
}

class ProfileDatasourceImpl implements ProfileDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;
  @override
  Future savePersonalDetails({required Map<String, dynamic> body}) async {
    try {
      final data = await dio.put(URL.UPDATE_PERSONAL_INFO, data: body);
      return data.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future updateSkills({required Map<String, dynamic> body}) async {
    try {
      await dio.post(URL.UPDATE_SKILL, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future updateJobPrefs({required Map<String, dynamic> body}) async {
    try {
      await dio.post(URL.UPDATE_CATEGORY, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future updateLanguagesReadAndWrite(
      {required Map<String, dynamic> body}) async {
    try {
      await dio.post(URL.LANGUAGES_READ_WRITE, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future updateLanguagesSpeak({required Map<String, dynamic> body}) async {
    try {
      await dio.post(URL.LANGUAGES_SPEAK, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future updateDocument({required Map<String, dynamic> body}) async {
    try {
      await dio.put(URL.UPDATE_DOCUMENT, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future getSavedJobs() async {
    try {
      Response data = await dio.get(URL.GET_SAVED_JOB);
      return data.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future getAppliedJobs() async {
    try {
      Response data = await dio.get(
        URL.APPLIED_JOBS,
      );
      return data.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
