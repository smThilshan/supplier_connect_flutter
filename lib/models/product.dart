class Product {
  final int id;
  final String name;
  final String? imageUrl;
  final double price;
  final int supplierId;

  Product({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.price,
    required this.supplierId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      supplierId: json['supplierId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'supplierId': supplierId,
    };
  }
}
