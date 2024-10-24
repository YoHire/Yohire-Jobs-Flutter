import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/shared_services/functions/device_id.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:http/http.dart' as http;
import '../../../../init_dependencies.dart';

abstract interface class JobRemoteDataSource {
  Future<dynamic> getAllJobs({required bool isLogged});
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  @override
  Future<dynamic> getAllJobs({required bool isLogged}) async {
    try {
      if (isLogged) {
        Response response;

        response = await dio.get(
          URL.JOBS,
        );
        return response.data;
      } else {
        http.Response data =
            await http.get(Uri.parse('${URL.ALL_JOBS}${await getDeviceId()}'));
        return json.decode(data.body);
      }
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
}
