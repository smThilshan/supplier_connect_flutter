import 'package:flutter/material.dart';

import '../services/api_service.dart';

class OrderProvider with ChangeNotifier {
  bool isPlacingOrder = false;

  Future<bool> placeOrder(List cartItems) async {
    isPlacingOrder = true;
    notifyListeners();

    final response =
        await ApiService.postRequest('orders', {'items': cartItems});
    isPlacingOrder = false;

    notifyListeners();
    return response.statusCode == 201;
  }
}
