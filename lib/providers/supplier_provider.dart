import 'package:flutter/material.dart';

class SupplierProvider extends ChangeNotifier {
  // Add your supplier-related properties and methods here
  // For example:
  List<String> _suppliers = [];

  List<String> get suppliers => _suppliers;
}
