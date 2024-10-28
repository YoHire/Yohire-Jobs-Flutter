import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/shared_services/user/models/user_model/user_model.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

class UserApiServices {
  final dio = serviceLocator<DioInterceptorHandler>().dio;
  final getStorage = serviceLocator<GetStorage>();
  Future<dynamic> getUser() async {
    try {
      if(getStorage.read('isLogged')==true){
        final response = await dio.get('${URL.USER}${getStorage.read('userId')}');
      return UserModel.fromJson(response.data['data']);
      }else{
        return null;
      }
    } catch (e) {
      log('error in get User');
      log(e.toString());
      throw Exception(e);
    }
  }
}
