import 'package:flutter/foundation.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  // Add product to cart or increase quantity if already exists
  void addProduct(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  // Increase quantity of a product
  void increaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity of a product
  void decreaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Remove product completely from cart
  void removeProduct(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  // Clear all items from cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Get total amount of the cart
  double get totalAmount {
    return _items.fold(
        0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}
