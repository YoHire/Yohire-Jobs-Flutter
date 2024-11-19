import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';
import 'package:http/http.dart' as http;

class CountryService {
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;

  Future<List<CountryModel>> allCountries() async {
    try {
      final url = Uri.parse(URL.ALL_COUNTRIES);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> results = data['data'];

        return results.map((json) => CountryModel.fromJson(json)).toList();
      } else {
        log('Failed to load countries: ${response.statusCode}');
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      log('Error in get countries');
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
