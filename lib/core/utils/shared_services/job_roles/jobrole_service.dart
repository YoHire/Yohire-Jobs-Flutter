import 'dart:convert';
import 'dart:developer';

import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:http/http.dart' as http;

class JobroleService {
  Future<List<JobRoleModel>> searchJobRoles(String keyword) async {
    try {
      final url = Uri.parse('${URL.SEARCH_JOB_ROLE}$keyword');
      final response = await http.get(url);

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        List<dynamic> results = data['data'];

        return results.map((json) => JobRoleModel.fromJson(json)).toList();
      } else {
        log('Failed to load searchJobRoles: ${response.statusCode}');
        throw Exception('Failed to load searchJobRoles');
      }
    } catch (e) {
      log('Error in get searchJobRoles');
      throw Exception(e.toString());
    }
  }
}
