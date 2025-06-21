import 'package:supplier_connect_flutter/models/product.dart';

class Supplier {
  final int id;
  final String name;
  final String? logoUrl;
  final double rating;
  final List<String> categories;
  final List<Product> products;

  Supplier({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.rating,
    required this.categories,
    required this.products,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic val) {
      if (val is int) return val;
      if (val is String) return int.tryParse(val) ?? 0;
      return 0;
    }

    double parseDouble(dynamic val) {
      if (val is double) return val;
      if (val is int) return val.toDouble();
      if (val is String) return double.tryParse(val) ?? 0.0;
      return 0.0;
    }

    double rating = parseDouble(json['rating']);

    List<String> categories = [];
    if (json['categories'] is String) {
      categories = (json['categories'] as String)
          .split(',')
          .map((e) => e.trim())
          .toList();
    } else if (json['categories'] is List) {
      categories = List<String>.from(json['categories']);
    }

    List<Product> parsedProducts = [];
    if (json['products'] != null && json['products'] is List) {
      parsedProducts = (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
    }

    return Supplier(
      id: parseInt(json['id']),
      name: json['name'] ?? '-',
      logoUrl: json['logo_url'],
      rating: rating,
      categories: categories,
      products: parsedProducts,
    );
  }
}
