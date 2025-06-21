import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

class CartScreen extends StatelessWidget {
  final int supplierId;
  const CartScreen({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final cartItems = cartProvider.items;

    double totalAmount = cartItems.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: item.product.imageUrl != null
                              ? Image.network(
                                  item.product.imageUrl!,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(item.product.name),
                          subtitle: Text(
                              '\$${item.product.price.toStringAsFixed(2)} each'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  cartProvider.decreaseQuantity(item.product);
                                },
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  cartProvider.increaseQuantity(item.product);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: orderProvider.isPlacingOrder
                          ? null
                          : () async {
                              // Convert cart items to List<OrderItem>
                              final orderItems = cartItems
                                  .map((item) => OrderItem(
                                        productId: item.product.id,
                                        quantity: item.quantity,
                                      ))
                                  .toList();

                              // final success = await orderProvider.placeOrder(
                              //     orderItems, totalAmount);
                              final success = await orderProvider.placeOrder(
                                userId: authProvider.userId!,
                                supplierId:
                                    supplierId, // Get this from your screen
                                items: orderItems,
                                totalPrice: totalAmount,
                              );

                              if (success) {
                                cartProvider.clearCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Order placed successfully!')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Order failed!')),
                                );
                              }
                            },
                      child: orderProvider.isPlacingOrder
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Place Order'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
