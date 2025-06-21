import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/supplier.dart';
import '../services/api_service.dart';

class SupplierProvider with ChangeNotifier {
  bool isLoading = false;
  String? error;
  List<Supplier> suppliers = [];
  Supplier? currentSupplier;

  // Already have this for listing suppliers
  Future<void> fetchSuppliers() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await ApiService.getRequest('suppliers');

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        suppliers = data.map((item) => Supplier.fromJson(item)).toList();
      } else {
        error = 'Failed to load suppliers';
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // NEW METHOD
  Future<void> fetchSupplierDetails(int id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await ApiService.getRequest('suppliers/$id');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        currentSupplier = Supplier.fromJson(data);
      } else {
        error = 'Failed to load supplier details';
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
