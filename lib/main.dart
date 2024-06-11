import 'package:flutter/material.dart';
import 'package:oshinstar/modules/home/screens/home.dart';
import 'package:oshinstar/modules/profile/screens/profile.dart';
import 'package:oshinstar/modules/splash/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), // Color for enabled underline
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue), // Color for focused underline
          ),
        ),
      ),
      home:  HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
