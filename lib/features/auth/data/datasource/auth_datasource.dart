import 'dart:convert';
import 'dart:developer';
import 'package:openbn/core/error/exception.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthDatasource {
  Future<dynamic> signIn({required Map<String, dynamic> body});
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
        log(data.toString());
        return data;
      } else {
        throw const ServerException('Could Not Complete Request');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
