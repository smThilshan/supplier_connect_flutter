import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/supplier.dart';
import '../models/product.dart';
import '../providers/supplier_provider.dart';
import '../providers/cart_provider.dart';

class SupplierDetailScreen extends StatefulWidget {
  static const routeName = '/supplier_details';
  final int supplierId;

  const SupplierDetailScreen({super.key, required this.supplierId});

  @override
  State<SupplierDetailScreen> createState() => _SupplierDetailScreenState();
}

class _SupplierDetailScreenState extends State<SupplierDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching supplier details
    Provider.of<SupplierProvider>(context, listen: false)
        .fetchSupplierDetails(widget.supplierId);
  }

  @override
  Widget build(BuildContext context) {
    final supplierProvider = Provider.of<SupplierProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart screen
              context.push('/cart', extra: widget.supplierId); // Thi
            },
          ),
        ],
      ),
      body: supplierProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : supplierProvider.error != null
              ? Center(child: Text('Error: ${supplierProvider.error}'))
              : supplierProvider.currentSupplier == null
                  ? const Center(child: Text('No details available'))
                  : _buildSupplierDetail(supplierProvider.currentSupplier!),
    );
  }

  Widget _buildSupplierDetail(Supplier supplier) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Supplier Info
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.teal[100],
          child: supplier.logoUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(supplier.logoUrl!,
                      fit: BoxFit.cover, height: 80, width: 80),
                )
              : Icon(Icons.store, color: Colors.teal[800], size: 40),
        ),
        const SizedBox(height: 12),
        Text(supplier.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(
            'Rating: ${supplier.rating.toStringAsFixed(1)} ★ | Categories: ${supplier.categories.join(', ')}'),
        const SizedBox(height: 16),
        const Text('Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Products List
        supplier.products.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No products available'),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: supplier.products.length,
                itemBuilder: (context, index) {
                  final product = supplier.products[index];
                  return _buildProductItem(product);
                },
              ),
      ],
    );
  }

  Widget _buildProductItem(Product product) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: product.imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(product.imageUrl!,
                    fit: BoxFit.cover, height: 60, width: 60),
              )
            : const Icon(Icons.image_not_supported),
        title: Text(product.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: ElevatedButton(
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .addProduct(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${product.name} added to cart!')),
            );
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            backgroundColor: Colors.teal,
          ),
          child: const Text('Add'),
        ),
      ),
    );
  }
}
