import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  /// currentIndex is the selected page index (0..3) from your pages list.
  final int currentIndex;
  final Function(int) onTabSelected;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorSelected = Theme.of(context).primaryColor;
    final colorUnselected = Colors.grey;

    Widget navIcon(IconData icon, String label, int pageIndex) {
      final isSelected = currentIndex == pageIndex;
      return Expanded(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTabSelected(pageIndex),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? colorSelected : colorUnselected,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? colorSelected : colorUnselected,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      elevation: 8.0,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Home, Services
            Row(
              children: [
                SizedBox(width: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Row(
                    children: [
                      navIcon(Icons.home, 'Home', 0),
                      navIcon(Icons.build, 'Services', 1),
                    ],
                  ),
                ),
              ],
            ),

            // Right side: Orders, Profile
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Row(
                    children: [
                      navIcon(Icons.receipt_long, 'Orders', 2),
                      navIcon(Icons.person_outline, 'Profile', 3),
                    ],
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
