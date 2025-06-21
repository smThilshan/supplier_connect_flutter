import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:supplier_connect_flutter/providers/cart_provider.dart';
import 'package:supplier_connect_flutter/providers/order_provider.dart';
import 'package:supplier_connect_flutter/views/cart_screen.dart';
import 'package:supplier_connect_flutter/views/login_screen.dart';
import 'package:supplier_connect_flutter/views/order_success_screen.dart';
import 'package:supplier_connect_flutter/views/supplier_detail_screen.dart';
import 'package:supplier_connect_flutter/views/supplier_list_screen.dart';

import 'providers/auth_provider.dart';
import 'providers/supplier_provider.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/suppliers',
      name: 'suppliers',
      builder: (context, state) => SupplierListScreen(),
      routes: [
        // Route for supplier details
        GoRoute(
          path: 'details/:id',
          name: 'supplier_details',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return SupplierDetailScreen(supplierId: id);
          },
        ),

        // GoRoute(
        //   path: 'order_success',
        //   name: 'order_success',
        //   builder: (context, state) {
        //     final orderId =
        //         int.tryParse(state.queryParams['orderId'] ?? '') ?? 0;
        //     final totalAmount =
        //         double.tryParse(state.queryParams['totalAmount'] ?? '') ?? 0.0;
        //     return OrderConfirmationScreen(
        //         orderId: orderId, totalAmount: totalAmount);
        //   },
        // ),
      ],
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) {
        final supplierId = state.extra as int;
        return CartScreen(supplierId: supplierId);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SupplierProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
        ],
        child: MaterialApp.router(
          title: 'Supplier Connect',
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ));
  }
}
