import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/supplier.dart';
import '../providers/supplier_provider.dart';

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  @override
  void initState() {
    super.initState();
    // IMPORTANT: Defer the call until after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SupplierProvider>(context, listen: false).fetchSuppliers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final supplierProvider = Provider.of<SupplierProvider>(context);

    if (supplierProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Suppliers')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (supplierProvider.error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Suppliers'),
        ),
        body: Center(child: Text('Error: ${supplierProvider.error}')),
      );
    }

    final List<Supplier> suppliers = supplierProvider.suppliers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
      ),
      backgroundColor: Colors.grey[100],
      body: suppliers.isEmpty
          ? const Center(child: Text('No suppliers available'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                final supplier = suppliers[index];
                return GestureDetector(
                  onTap: () {
                    // context.push('/supplier_details', extra: supplier.id);
                    context.push('/suppliers/details/${supplier.id}');
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
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.teal[100],
                            child: supplier.logoUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      supplier.logoUrl!,
                                      fit: BoxFit.cover,
                                      height: 60,
                                      width: 60,
                                    ),
                                  )
                                : const Icon(Icons.store,
                                    color: Colors.teal, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(supplier.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('Rating: ${supplier.rating} ★',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.orange[700])),
                                const SizedBox(height: 4),
                                Text(
                                  'Categories: ${supplier.categories.join(', ')}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: Colors.teal),
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
