class Order {
  final int id;
  final List<OrderItem> items;
  final double totalPrice;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List<dynamic>;
    List<OrderItem> itemsList =
        itemsJson.map((e) => OrderItem.fromJson(e)).toList();

    return Order(
      id: json['id'],
      items: itemsList,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class OrderItem {
  final int productId;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
