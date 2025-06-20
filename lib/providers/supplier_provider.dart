import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supplier_connect_flutter/services/api_service.dart';

// class SupplierProvider extends ChangeNotifier {
//   // Add your supplier-related properties and methods here
//   // For example:
//   List<String> _suppliers = [];

//   List<String> get suppliers => _suppliers;
// }

// class SupplierProvider with ChangeNotifier {
//   List suppliers = [];
//   bool isLoading = false;

//   Future<void> fetchSuppliers() async {
//     isLoading = true;
//     notifyListeners();

//     final response = await ApiService.getRequest('suppliers');
//     if (response.statusCode == 200) {
//       suppliers = jsonDecode(response.body);
//     }
//     isLoading = false;
//     notifyListeners();
//   }
// }

class SupplierProvider with ChangeNotifier {
  List suppliers = [];
  bool isLoading = false;

  Future<void> fetchSuppliers() async {
    isLoading = true;
    notifyListeners();

    final response = await ApiService.getRequest('suppliers');
    if (response.statusCode == 200) {
      suppliers = jsonDecode(response.body);
      // 👇 Print to console
      print('Fetched Suppliers: $suppliers');
    } else {
      print('Error ${response.statusCode}: ${response.body}');
    }

    isLoading = false;
    notifyListeners();
  }
}
