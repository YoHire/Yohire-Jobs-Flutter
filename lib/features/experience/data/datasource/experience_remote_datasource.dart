import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

abstract interface class ExperienceRemoteDatasource {
  Future<void> saveExperience(Map<String, dynamic> data);
  Future<void> deleteExperience(String experienceId);
  Future<void> editExperience(Map<String, dynamic> data);
}

class ExperienceRemoteDatasourceImpl implements ExperienceRemoteDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  @override
  Future<void> saveExperience(Map<String, dynamic> data) async {
    try {
      await dio.post(URL.ADD_EXPERIENCE, data: data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteExperience(String experienceId) async {
    try {
      await dio.delete('${URL.DELETE_EXPERIENCE}$experienceId');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> editExperience(Map<String, dynamic> data) async {
    try {
      await dio.put(URL.UPDATE_EXPERIENCE, data: data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
