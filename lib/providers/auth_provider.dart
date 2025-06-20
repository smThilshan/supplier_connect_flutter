import 'package:flutter/material.dart';
import 'package:supplier_connect_flutter/services/api_service.dart';

// class AuthProvider extends ChangeNotifier {
//   // Add your supplier-related properties and methods here
//   // For example:
//   List<String> _suppliers = [];

//   List<String> get suppliers => _suppliers;
// }

// auth_provider.dart
class AuthProvider with ChangeNotifier {
  bool isLoading = false;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    // This assumes the backend expects email & password
    final response = await ApiService.postRequest('login', {
      'email': email,
      'password': password,
    });
    isLoading = false;

    if (response.statusCode == 200) {
      // You can save token or do any other logic
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
