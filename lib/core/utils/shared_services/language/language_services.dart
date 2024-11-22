import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';


class LanguageService {
   Future<List<LanguageModel>> searchLanguages(String keyword) async {
     Dio dio = serviceLocator<DioInterceptorHandler>().dio;
    try {
      Response response = await dio.get(
        '${URL.LANGUAGES}$keyword',
      );
      List<dynamic>results = response.data['data'];
      return results.map((json)=>LanguageModel.fromJson(json)).toList();
    } catch (e) {
      log('error in get languages');
      log(e.toString());
      throw Exception(e);
    }
  }
}
