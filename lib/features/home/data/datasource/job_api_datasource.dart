import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:http/http.dart' as http;
import '../../../../init_dependencies.dart';

abstract interface class JobApiDatasource {
  Future<dynamic> getJobById({required String id, required bool isLogged});
  Future<dynamic> applyJob(Map<String, dynamic> body);
}

class JobApiDatasourceImpl implements JobApiDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  @override
  Future<dynamic> getJobById(
      {required String id, required bool isLogged}) async {
    try {
      if (isLogged) {
        Response response;
        response = await dio.get(
          '${URL.GET_JOB_BY_ID}$id',
        );
        return response.data;
      } else {
        http.Response data =
            await http.get(Uri.parse('${URL.GET_JOB_BY_ID_LOGOUT}$id'));
        return json.decode(data.body);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> applyJob(Map<String, dynamic> body) async {
    try {
      await dio.post(URL.APPLY, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
