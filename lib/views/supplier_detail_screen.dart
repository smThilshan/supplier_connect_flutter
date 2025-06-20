import 'package:flutter/material.dart';

class SupplierDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> supplier = {
    'id': 1,
    'name': 'Fresh Foods Co.',
    'logoUrl': null,
    'rating': 4.5,
    'categories': ['Fruits', 'Vegetables'],
    'products': [
      {
        'id': 101,
        'name': 'Apple',
        'imageUrl': null,
        'price': 1.25,
      },
      {
        'id': 102,
        'name': 'Banana',
        'imageUrl': null,
        'price': 0.99,
      },
      {
        'id': 103,
        'name': 'Carrot',
        'imageUrl': null,
        'price': 0.89,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supplier['name']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Supplier Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.teal[100],
                      child:
                          Icon(Icons.store, size: 40, color: Colors.teal[800]),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            supplier['name'],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Rating: ${supplier['rating']} ★',
                            style: TextStyle(
                                fontSize: 16, color: Colors.orange[700]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Categories: ${supplier['categories'].join(', ')}',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Products Section Title
            Text(
              'Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Product List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: supplier['products'].length,
              itemBuilder: (context, index) {
                final product = supplier['products'][index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Icon(Icons.local_grocery_store,
                          color: Colors.orange[700]),
                    ),
                    title: Text(product['name']),
                    subtitle: Text('\$${product['price'].toStringAsFixed(2)}'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to product details or add to cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped on ${product['name']}')),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
