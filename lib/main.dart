import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/services_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/profile_screen.dart';
import 'data/app_store.dart';
import 'components/bottom_nav.dart';

void main() {
  runApp(const LabourApp());
}

class LabourApp extends StatefulWidget {
  const LabourApp({super.key});

  @override
  State<LabourApp> createState() => _LabourAppState();
}

class _LabourAppState extends State<LabourApp>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isWorker = false;

  late final AnimationController _fabController;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _onPlusPressed() async {
    // rotate once
    await _fabController.forward(from: 0.0);

    // show menu
    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.post_add),
              title: const Text('Create Service'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Create Service tapped')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text('Post a Job'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post a Job tapped')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );

    // reverse rotation when closing
    if (mounted) _fabController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pak Labour',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
        ),
      ),
      home: const SplashScreen(),
      routes: {'/home': (context) => _buildMainApp(context)},
    );
  }

  Widget _buildMainApp(BuildContext context) {
    return Builder(
      builder: (context) {
        final pages = [
          const HomeScreen(),
          ServicesScreen(isWorker: _isWorker),
          const OrdersScreen(),
          ProfileScreen(
            isWorker: _isWorker,
            onModeChanged: (v) {
              setState(() => _isWorker = v);
              AppStore.isWorkerMode = v; // Sync with AppStore
            },
          ),
        ];

        return Scaffold(
          body: pages[_currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _isWorker
              ? RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _fabController,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: FloatingActionButton(
                    onPressed: _onPlusPressed,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.add, size: 32),
                  ),
                )
              : FloatingActionButton(
                  onPressed: () async {
                    // show simple map placeholder
                    await showModalBottomSheet(
                      context: context,
                      builder: (_) => SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            'Map placeholder - show map here',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 28),
                ),
          bottomNavigationBar: BottomNav(
            currentIndex: _currentIndex,
            onTabSelected: _onTabTapped,
          ),
        );
      },
    );
  }
}
