import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _appNameController;
  late Animation<double> _animation2;
  late Animation<double> _appNameAnimation;

  @override
  void initState() {
    super.initState();

    // First image animation controller
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Second image animation controller
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // App name animation controller
    _appNameController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Fade animations
    _animation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeIn));

    _appNameAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _appNameController, curve: Curves.easeIn),
    );

    // Start animations sequentially
    _controller1.forward();

    // Second image appears after first one fades
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller2.forward();
      }
    });

    // App name appears after second image
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _appNameController.forward();
      }
    });

    // Navigate to home after total splash duration
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _appNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // First image - appears first, then fades out
          FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(parent: _controller1, curve: Curves.easeInOut),
            ),
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/splash_screen_1.jpg',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          // Second image - appears after first fades, stays with app name
          FadeTransition(
            opacity: _animation2,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash_screen_2.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  const SizedBox(height: 40),
                  // App name appears last
                  FadeTransition(
                    opacity: _appNameAnimation,
                    child: const Text(
                      'Pak Labour',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C5282),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
