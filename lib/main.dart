import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/services_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/profile_screen.dart';
import 'components/bottom_nav.dart';

void main() {
  runApp(const LabourApp());
}

class LabourApp extends StatefulWidget {
  const LabourApp({super.key});

  @override
  State<LabourApp> createState() => _LabourAppState();
}

class _LabourAppState extends State<LabourApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ServicesScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pak Labour',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNav(
          currentIndex: _currentIndex,
          onTabSelected: _onTabTapped,
        ),
      ),
    );
  }
}
