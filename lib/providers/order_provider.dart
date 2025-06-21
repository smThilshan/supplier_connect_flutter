import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/api_service.dart';

// class OrderProvider with ChangeNotifier {
//   bool isPlacingOrder = false;

//   Future<bool> placeOrder(List cartItems) async {
//     isPlacingOrder = true;
//     notifyListeners();

//     final response =
//         await ApiService.postRequest('orders', {'items': cartItems});
//     isPlacingOrder = false;

//     notifyListeners();
//     return response.statusCode == 201;
//   }
// }

class OrderProvider with ChangeNotifier {
  bool isPlacingOrder = false;

  Future<bool> placeOrder(List<OrderItem> items, double totalPrice) async {
    isPlacingOrder = true;
    notifyListeners();

    final orderData = {
      'items': items.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
    };
    final response = await ApiService.postRequest('orders', orderData);

    isPlacingOrder = false;
    notifyListeners();

    return response.statusCode == 201;
  }
}
