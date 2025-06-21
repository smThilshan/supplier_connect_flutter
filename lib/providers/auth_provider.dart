import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supplier_connect_flutter/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;

  String? token;
  int? userId;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final response = await ApiService.postRequest('login', {
      'email': email,
      'password': password,
    });
    isLoading = false;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['token'];
      userId = data['user']['id'];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
