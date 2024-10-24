// lib/core/services/dio_interceptor_handler.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openbn/core/utils/urls.dart';


class DioInterceptorHandler {

  final Dio dio = Dio();

  void setupDio() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the access token to the request header
          options.headers['Authorization'] =
              'Bearer ${GetStorage().read('accessToken')}';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // If a 401 response is received, refresh the access token
            String newAccessToken =
                await refreshAccessToken(GetStorage().read('refreshToken'));

            // Update the request header with the new access token
            e.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';

            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<String> refreshAccessToken(refreshToken) async {
    final response = await http
        .post(Uri.parse(URL.REFRESH), body: {"refreshToken": refreshToken});

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      GetStorage().write("accessToken", data["accessToken"]);
      GetStorage().write("refreshToken", data["refreshToken"]);
      return data['accessToken'];
    } else {
      // snackbarController.showError(
      //     'Something went wrong', '${response.statusCode} Please login again');
      GetStorage().erase();
      // Get.offAll(() => const OnBoarding());
      // await FirebaseApi().deleteFcmId();
    }
    return '';
  }
}
