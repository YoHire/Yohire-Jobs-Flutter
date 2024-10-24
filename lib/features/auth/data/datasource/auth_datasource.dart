import 'dart:convert';
import 'dart:developer';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthDatasource {
  Future<dynamic> signIn({required Map<String, dynamic> body});
  Future<dynamic> verifyPhone({required Map<String, dynamic> body});
  Future<dynamic> checkPhoneNumber({required String phone});
}

class AuthDatasourceImpl implements AuthDatasource {
  @override
  Future<dynamic> signIn({required Map<String, dynamic> body}) async {
    try {
      final response = await http.post(
        Uri.parse(URL.LOGIN),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data;
      } else {
        log(const ServerException('Could Not Complete Request').message);
        throw 'Could Not Complete Request';
      }
    } catch (e) {
      log(ServerException(e.toString()).message);
      throw 'Something went wrong please try again after some time';
    }
  }

  @override
  Future<dynamic> checkPhoneNumber({required String phone}) async {
    try {
      Map<String, String> body = {
        "phone": phone,
      };
      final response = await http.post(
        Uri.parse(URL.CHECK_PHONE),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      return json.decode(response.body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> verifyPhone({required Map<String, dynamic> body}) async {
    try {
      final response = await http.post(
        Uri.parse(URL.VERIFY_PHONE),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data;
      }else{
        throw const ServerException('Could Not Complete Request');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
}
