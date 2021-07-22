import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({
    this.baseUrl = 'https://api.github.com/orgs/google/repos?type=public',
  });

  Future<List<dynamic>> fetchRepos(int page) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + '&page=$page&per_page=10'));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      return [];
    }
  }
}
