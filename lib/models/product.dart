class Product {
  final int id;
  final int supplierId;
  final String name;
  final String? imageUrl;
  final double price;

  Product({
    required this.id,
    required this.supplierId,
    required this.name,
    this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic val) {
      if (val is double) return val;
      if (val is int) return val.toDouble();
      if (val is String) return double.tryParse(val) ?? 0.0;
      return 0.0;
    }

    return Product(
      id: json['id'] ?? 0,
      supplierId: json['supplier_id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['image_url'],
      price: parseDouble(json['price']),
    );
  }
}
