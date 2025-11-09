import 'package:flutter/material.dart';
import '../components/category_item.dart';
import '../components/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.location_on_outlined, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text("Lahore, Pakistan",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Icon(Icons.notifications_outlined),
                ],
              ),
            ),

            // Categories
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  CategoryItem(label: 'Plumber', imagePath: 'assets/images/plumber.png'),
                  SizedBox(width: 12),
                  CategoryItem(label: 'Electrician', imagePath: 'assets/images/electrician.png'),
                  SizedBox(width: 12),
                  CategoryItem(label: 'Cleaner', imagePath: 'assets/images/cleaner.png'),
                  SizedBox(width: 12),
                  CategoryItem(label: 'Painter', imagePath: 'assets/images/painter.png'),
                  SizedBox(width: 12),
                  CategoryItem(label: 'Carpenter', imagePath: 'assets/images/carpenter.png'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/banner.png', fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 16),

            // Featured Services
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Top Rated Workers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  ServiceCard(title: "Ali - Plumber", subtitle: "5⭐ (20 Reviews)", imagePath: 'assets/images/plumber.png'),
                  ServiceCard(title: "Ahmed - Electrician", subtitle: "4.8⭐ (15 Reviews)", imagePath: 'assets/images/electrician.png'),
                  ServiceCard(title: "Zain - Cleaner", subtitle: "4.9⭐ (10 Reviews)", imagePath: 'assets/images/cleaner.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
