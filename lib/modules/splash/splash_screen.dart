import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/first_last_name.dart';
import 'package:oshinstar/modules/authentication/screens/birth_gender.dart';
import 'package:oshinstar/modules/authentication/screens/phone_number.dart';
import 'package:oshinstar/modules/landing/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _checkUser();
  }

  Future<void> _checkUser() async {
    await Hive.initFlutter();
    final box = await Hive.openBox('userBox');
    final userId = box.get('userId');

    if (userId != null) {
      final response = await AuthenticationApi.getUser(userId);
      final user = response;

      if (user['firstName'].isEmpty || user['lastName'].isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirstLastNameScreen()),
        );
      } else if (user['birthdate'] == null || user['gender'].isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BirthGenderScreen()),
        );
      } else if ((!user['phone'].isEmpty && user["isPhoneVerified"] == false) ||
          (user["phone"].isEmpty && user["isPhoneVerified"] == false)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PhoneNumberScreen(
                    returning: !user["phone"].isEmpty,
                    phone: user["phone"] ?? ""
                  )),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
      );
    }

    _controller!.stop();
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
          child:
              Image.asset("assets/oshinstar-logo.png", height: 150, width: 150),
        ),
      ),
    );
  }
}
