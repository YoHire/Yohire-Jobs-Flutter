import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

abstract interface class JobrolesRemoteDataSource {
  Future<dynamic> getJobRoles({String industry = 'none'});
  Future<dynamic> searchJobRoles({required String keyword});
  Future<void> createGuestUser(Map<String, dynamic> body);
}

class JobrolesRemoteDataSourceImpl implements JobrolesRemoteDataSource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;
  @override
  Future<dynamic> getJobRoles({String industry = 'none'}) async {
    try {
      final data = await dio.get('${URL.RANDOM_JOB_ROLES}$industry');
      return data.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> searchJobRoles({required String keyword}) async {
    try {
      final data = await dio.get('${URL.SEARCH_JOB_ROLE}$keyword');
      return data.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createGuestUser(Map<String, dynamic> body) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      await http.post(
        Uri.parse(URL.GUEST_SIGNUP),
        headers: headers,
        body: json.encode(body),
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
