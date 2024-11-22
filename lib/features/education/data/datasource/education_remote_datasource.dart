import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

abstract interface class EducationRemoteDataSource {
  Future<dynamic> getCategories();
  Future<dynamic> getSubCategories(String category);
  Future<dynamic> getCourses(String category, String? subCategory);
  Future<void> saveEducation(Map<String, dynamic> data);
  Future<void> updateEducation(Map<String, dynamic> data);
  Future<void> deleteEducation(String id);
}

class EducationRemoteDataSourceImpl implements EducationRemoteDataSource {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;
  @override
  Future<dynamic> getCategories() async {
    try {
      Response response;

      response = await dio.get(
        URL.QUALIFICATIONS_CATEGORY,
      );
      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> getCourses(String category, String? subCategory) async {
    try {
      Response response;
      String url = '';
      if (subCategory == null || subCategory.isEmpty) {
        url = '${URL.QUALIFICATIONS_COURSE}$category/none';
      } else {
        url = '${URL.QUALIFICATIONS_COURSE}$category/$subCategory';
      }
      response = await dio.get(
        url,
      );
      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> getSubCategories(String category) async {
    try {
      Response response;

      response = await dio.get(
        '${URL.QUALIFICATIONS_SUBCATEGORY}$category',
      );
      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveEducation(Map<String, dynamic> data) async {
    try {
      await dio.post(URL.ADD_EDUCATION, data: data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> updateEducation(Map<String, dynamic> data) async{
    try {
      await dio.put(URL.UPDATE_EDUCATION, data: data);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> deleteEducation(String id) async{
    try {
      await dio.delete('${URL.DELETE_EDUCATION}$id');
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
}
