class Supplier {
  final int id;
  final String name;
  final String? logoUrl;
  final double rating;
  final List<String> categories;

  Supplier({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.rating,
    required this.categories,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    // Handle rating flexibly
    double parsedRating = 0.0;
    var ratingData = json['rating'];
    if (ratingData is String) {
      parsedRating = double.tryParse(ratingData) ?? 0.0;
    } else if (ratingData is int) {
      parsedRating = ratingData.toDouble();
    } else if (ratingData is double) {
      parsedRating = ratingData;
    }

    List<String> parsedCategories = [];
    if (json['categories'] is String) {
      parsedCategories = (json['categories'] as String).split(',');
    } else if (json['categories'] is List) {
      parsedCategories = List<String>.from(json['categories']);
    }

    return Supplier(
      id: json['id'] ?? 0,
      name: json['name'] ?? '-',
      logoUrl: json['logoUrl'],
      rating: parsedRating,
      categories: parsedCategories,
    );
  }
}
