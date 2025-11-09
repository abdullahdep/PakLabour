import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String imagePath;

  const CategoryItem({super.key, required this.label, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade50,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
