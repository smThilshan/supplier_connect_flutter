import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/supplier_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SupplierProvider>(context, listen: false).fetchSuppliers();
    print("Fetching suppliers in splash screen");
  }

  @override
  Widget build(BuildContext context) {
    return Text("JUST A SPLASH SCREEN");
  }
}
