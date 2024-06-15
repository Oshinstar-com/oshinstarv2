import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/helpers/hive.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/account_type.dart';
import 'package:oshinstar/modules/authentication/screens/categories_picker.dart';
import 'package:oshinstar/modules/authentication/screens/first_last_name.dart';
import 'package:oshinstar/modules/authentication/screens/birth_gender.dart';
import 'package:oshinstar/modules/authentication/screens/phone_number.dart';
import 'package:oshinstar/modules/home/screens/home.dart';
import 'package:oshinstar/modules/landing/landing_screen.dart';
import 'package:oshinstar/modules/splash/api/initial_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _setInitialAppData();
    await _checkUser();
  }

  Future<void> _setInitialAppData() async {
    final appDataHiveManager = AppDataHiveManager();
    await appDataHiveManager.initBox('appData');

    final response = await InitialApi.fetchInitialData();
    await appDataHiveManager.write('industries', response["industries"]);
  }

  Future<void> _checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final isValidToken = await _validateToken(token);

      if (isValidToken) {
        _navigateToScreen(const HomeScreen());
        return;
      } else {
        final refreshToken = prefs.getString('refreshToken');
        if (refreshToken != null) {
          final response = await AuthenticationApi.refreshToken(refreshToken);
          if (response.containsKey('token')) {
            prefs.setString('token', response['token']);
            _navigateToScreen(const HomeScreen());
            return;
          }
        }
      }
    }

    await Hive.initFlutter();
    final userHiveManager = UserHiveManager();
    await userHiveManager.initBox('userBox');

    final userId = await userHiveManager.readData('userId');

    if (userId != null) {
      final response = await AuthenticationApi.getUser(userId);
      final user = response;

      context.read<UserCubit>().setUserInfo(user);

      if (user['firstName'].isEmpty || user['lastName'].isEmpty) {
        _navigateToScreen(const FirstLastNameScreen());
      } else if (user['birthdate'] == null || user['gender'].isEmpty) {
        _navigateToScreen(const BirthGenderScreen());
      } else if ((!user['phone'].isEmpty && user["isPhoneVerified"] == false) ||
          (user["phone"].isEmpty && user["isPhoneVerified"] == false)) {
        _navigateToScreen(
          PhoneNumberScreen(returning: !user["phone"].isEmpty, phone: user["phone"] ?? ""),
        );
      } else if (user['accountType'].isEmpty || user['accountType'] == null) {
        _navigateToScreen(const AccountTypeScreen());
      } else if (user['categories'].isEmpty) {
        _navigateToScreen(const CategoriesPickerPage());
      } else {
        _navigateToScreen(LandingScreen());
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        _navigateToScreen(LandingScreen());
      });
    }
  }

  Future<bool> _validateToken(String token) async {
    final response = await http.get(
      Uri.parse('https://dcfe-179-53-44-76.ngrok-free.app/api/v1/user/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response.statusCode == 200;
  }

  void _navigateToScreen(Widget screen) {
    _controller?.stop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
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
