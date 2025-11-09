import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("📦 Your Orders Page", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}
