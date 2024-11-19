import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

abstract interface class CircleRemoteDatasource {
  Future<dynamic> getQueues();
  Future<dynamic> getInvitations({required String queueId});
  Future<dynamic> createQueue({required Map<String, dynamic> data});
}

class CircleRemoteDatasourceImpl implements CircleRemoteDatasource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  @override
  Future getQueues() async {
    try {
      Response response;
      response = await dio.get(
        URL.GET_ALL_QUEUES,
      );
      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> getInvitations({required String queueId}) async {
    try {
      Response response;
      response = await dio.get(
        '${URL.GET_ALL_INVITATIONS}$queueId',
      );
      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> createQueue({required Map<String, dynamic> data}) async {
    try {
      await dio.post(URL.CREATE_QUEUE, data: data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
