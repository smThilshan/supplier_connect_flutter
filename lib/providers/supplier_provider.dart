import 'package:flutter/material.dart';
import 'package:supplier_connect_flutter/services/api_service.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/supplier.dart';
import '../services/api_service.dart';

class SupplierProvider with ChangeNotifier {
  List<Supplier> _suppliers = [];
  bool _isLoading = false;
  String? _error;

  List<Supplier> get suppliers => _suppliers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSuppliers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getRequest('suppliers');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List suppliersData = data is List ? data : data['suppliers'];
        _suppliers = suppliersData
            .map((supplier) => Supplier.fromJson(supplier))
            .toList();
      } else {
        _error = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Exception: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
