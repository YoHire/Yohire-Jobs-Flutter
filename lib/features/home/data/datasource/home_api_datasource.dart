import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/shared_services/functions/device_id.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:http/http.dart' as http;
import '../../../../init_dependencies.dart';

abstract interface class HomeApiDatasource {
  Future<dynamic> getAllJobs({required bool isLogged});
  Future<dynamic> getMoreJobs({required bool isLogged, required int skipCount});
  Future<dynamic> filterJobs(
      {required bool isLogged, required Map<String, dynamic> filterData});
}

class HomeApiDatasourceImpl implements HomeApiDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  @override
  Future<dynamic> getAllJobs({required bool isLogged}) async {
    try {
      if (isLogged) {
        Response response;
        response = await dio.get(
          '${URL.JOBS}0',
        );
        return response.data;
      } else {
        http.Response data =
            await http.get(Uri.parse('${URL.ALL_JOBS}${await getDeviceId()}'));
        return json.decode(data.body);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> getMoreJobs(
      {required bool isLogged, required int skipCount}) async {
    try {
      if (isLogged) {
        Response response;
        response = await dio.get(
          '${URL.JOBS}$skipCount',
        );
        return response.data;
      } else {
        http.Response data =
            await http.get(Uri.parse('${URL.ALL_JOBS}${await getDeviceId()}'));
        return json.decode(data.body);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> filterJobs(
      {required bool isLogged,
      required Map<String, dynamic> filterData}) async {
    try {
      Response response;
      response = await dio.post(URL.FILTER_JOBS, data: filterData);
      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
