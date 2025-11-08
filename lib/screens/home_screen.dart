import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Home Page'),
      body: const Center(
        child: Text(
          'Welcome to Flutter Home!',
          style: TextStyle(fontSize: 22),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
