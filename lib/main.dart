import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SupplierProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
          title: 'Supplier Connect',
          theme: ThemeData(useMaterial3: true),
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          // ),
          debugShowCheckedModeBanner: false,

          home: OrderConfirmationScreen(orderId: 12, totalAmount: 150.00),
        ));
  }
}
