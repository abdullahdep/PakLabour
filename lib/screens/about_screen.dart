import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'About Us'),
      body: const Center(
        child: Text(
          'This is the About Page of your Flutter App.',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
