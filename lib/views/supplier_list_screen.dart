// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/supplier_provider.dart';
// import '../models/supplier.dart';
// import '../widgets/supplier_card.dart'; // Optional for cleaner UI

// class SupplierListScreen extends StatefulWidget {
//   @override
//   _SupplierListScreenState createState() => _SupplierListScreenState();
// }

// class _SupplierListScreenState extends State<SupplierListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<SupplierProvider>(context, listen: false).fetchSuppliers('test_token_12345');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SupplierProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('Suppliers')),
//       body: provider.isLoading
//           ? Center(child: CircularProgressIndicator())
//           : provider.error != null
//               ? Center(child: Text('Error: ${provider.error}'))
//               : ListView.builder(
//                   itemCount: provider.suppliers.length,
//                   itemBuilder: (context, index) {
//                     Supplier supplier = provider.suppliers[index];
//                     return ListTile(
//                       leading: supplier.logoUrl != null
//                           ? Image.network(supplier.logoUrl!, width: 40)
//                           : Icon(Icons.store),
//                       title: Text(supplier.name),
//                       subtitle: Text("Rating: ${supplier.rating}"),
//                       onTap: () {
//                         Navigator.pushNamed(
//                           context,
//                           '/supplier-details',
//                           arguments: supplier.id,
//                         );
//                       },
//                     );
//                   },
//                 ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SupplierListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dummySuppliers = [
    {
      'id': 1,
      'name': 'Fresh Foods Co.',
      'logoUrl': null,
      'rating': 4.5,
      'categories': ['Fruits', 'Vegetables']
    },
    {
      'id': 2,
      'name': 'Dairy Delight',
      'logoUrl': null,
      'rating': 4.2,
      'categories': ['Milk', 'Cheese']
    },
    {
      'id': 3,
      'name': 'Bakers Hub',
      'logoUrl': null,
      'rating': 4.8,
      'categories': ['Bread', 'Pastry']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text('Suppliers')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dummySuppliers.length,
        itemBuilder: (context, index) {
          final supplier = dummySuppliers[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Clicked on ${supplier['name']}')),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Placeholder for logo
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.teal[100],
                      child:
                          Icon(Icons.store, color: Colors.teal[800], size: 30),
                    ),
                    SizedBox(width: 16),
                    // Supplier Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            supplier['name'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rating: ${supplier['rating']} ★',
                            style: TextStyle(
                                fontSize: 14, color: Colors.orange[700]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Categories: ${supplier['categories'].join(', ')}',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.teal),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
