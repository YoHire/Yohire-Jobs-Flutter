import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

class UserSkillService {
  Future<List<SkillModel>> searchSkills(String keyword) async {
    try {
      Dio dio = serviceLocator<DioInterceptorHandler>().dio;
      Response response = await dio.get(
        '${URL.SEARCH_SKILL}$keyword',
      );
      List<dynamic> results = response.data['data'];
      return results.map((json) => SkillModel.fromJson(json)).toList();
    } catch (e) {
      log('error in search skills');
      log(e.toString());
      throw Exception(e);
    }
  }
}
