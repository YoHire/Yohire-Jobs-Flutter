import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

abstract interface class ProfileDatasource {
  Future<dynamic> savePersonalDetails({required Map<String, dynamic> body});
}

class ProfileDatasourceImpl implements ProfileDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;
  @override
  Future savePersonalDetails({required Map<String, dynamic> body}) async {
    try {
      final data = await dio.put(URL.UPDATE_PERSONAL_INFO, data: body);
      return data.data;
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
}
