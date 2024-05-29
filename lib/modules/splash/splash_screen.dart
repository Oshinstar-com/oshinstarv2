import 'package:flutter/material.dart';
import 'package:oshinstar/modules/landing/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), 
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 1), () {
      _controller!.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()), 
      );
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller!.value * 2 * 3.14159,
              child: child,
            );
          },
          child: Image.asset("assets/oshinstar-logo.png", height: 150, width: 150),
        ),
      ),
    );
  }
}
