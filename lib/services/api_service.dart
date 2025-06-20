import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static Map<String, String> get headers => {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Constants.authToken}',
      };

  static Future<http.Response> getRequest(String endpoint) {
    return http.get(
      Uri.parse('${Constants.baseUrl}/$endpoint'),
      headers: headers,
    );
  }

  static Future<http.Response> postRequest(String endpoint, dynamic body) {
    return http.post(
      Uri.parse('${Constants.baseUrl}/$endpoint'),
      headers: {
        ...headers,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  }
}
