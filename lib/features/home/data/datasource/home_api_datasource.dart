import 'dart:convert';
import 'dart:developer';
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
  Future<dynamic> saveJob({required String jobId});
  Future<dynamic> unSaveJob({required String jobId});
}

class HomeApiDatasourceImpl implements HomeApiDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  @override
  Future<dynamic> getAllJobs({required bool isLogged}) async {
    try {
      if (isLogged) {
        Response response;
        response = await dio.get(
          '${URL.PREFRENCE_JOBS}0',
        );
        return response.data;
      } else {
        http.Response data =
            await http.get(Uri.parse('${URL.ALL_JOBS}${await getDeviceId()}/0'));
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
          '${URL.PREFRENCE_JOBS}$skipCount',
        );
        return response.data;
      } else {
        http.Response data =
            await http.get(Uri.parse('${URL.ALL_JOBS}${await getDeviceId()}/$skipCount'));
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

  @override
  Future saveJob({required String jobId}) async {
    try {
      Map<String, dynamic> body = {"jobId": jobId};

      await dio.post(URL.SAVE_JOB, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future unSaveJob({required String jobId}) async {
    try {
      Map<String, dynamic> body = {"jobId": jobId};

      await dio.post(URL.UNSAVE_JOB, data: body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
