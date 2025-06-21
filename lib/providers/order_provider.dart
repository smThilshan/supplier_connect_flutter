import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplier_connect_flutter/providers/auth_provider.dart';
import '../models/order.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class OrderProvider with ChangeNotifier {
  bool isPlacingOrder = false;

  Future<bool> placeOrder({
    required int userId,
    required int supplierId,
    required List<OrderItem> items,
    required double totalPrice,
  }) async {
    isPlacingOrder = true;
    notifyListeners();

    final orderData = {
      'user_id': userId,
      'supplier_id': supplierId,
      'items': items.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
    };
    final response = await ApiService.postRequest('orders', orderData);
    print('Order POST response status: ${response.statusCode}');
    print('Order POST response body: ${response.body}');

    isPlacingOrder = false;
    notifyListeners();

    return response.statusCode == 201;
  }
}
