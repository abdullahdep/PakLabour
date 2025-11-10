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
    final colorSelected = Theme.of(context).colorScheme.primary;
    final colorUnselected =
        Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6) ??
        Colors.grey;

    Widget navIcon(IconData icon, String label, int pageIndex) {
      final isSelected = currentIndex == pageIndex;
      return InkWell(
        onTap: () => onTabSelected(pageIndex),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? colorSelected : colorUnselected,
                size: 22,
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
      );
    }

    // Reserve center space for FAB notch. This avoids fractional widths that may overflow by a pixel.
    final fabReserve = 72.0; // space reserved for FAB (diameter + margins)

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      elevation: 8.0,
      color: Theme.of(context).cardColor,
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            // left two icons
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navIcon(Icons.home_outlined, 'Home', 0),
                  navIcon(Icons.build_outlined, 'Services', 1),
                ],
              ),
            ),

            // center spacer for FAB
            SizedBox(width: fabReserve),

            // right two icons
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navIcon(Icons.receipt_long_outlined, 'Orders', 2),
                  navIcon(Icons.person_outline, 'Profile', 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
