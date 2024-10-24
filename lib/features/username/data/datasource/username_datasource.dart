import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import '../../../../init_dependencies.dart';

abstract interface class UsernameRemoteDatasource {
  Future<dynamic> saveUsername({required Map<String, dynamic> body});
}

class UsernameRemoteDatasourceImpl implements UsernameRemoteDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  @override
  Future<dynamic> saveUsername({required Map<String, dynamic> body}) async {
    try {
      Response response;
      response = await dio.patch(URL.UPDATE_USERNAME, data: body);
      return response.data;
    } catch (e) {
      ServerException(e.toString());
      throw 'Something went wrong';
    }
  }
}
