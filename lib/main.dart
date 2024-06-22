import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:oshinstar/modules/splash/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/cubits.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const Oshinstar());
}

class Oshinstar extends StatelessWidget {
  const Oshinstar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<MetaCubit>(create: (context) => MetaCubit())
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyLarge: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            bodyMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            displayLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            displayMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            displaySmall: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            headlineMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            headlineSmall: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            titleLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            titleMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            titleSmall: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            bodySmall: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
            labelSmall: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900), // Black font weight
          ).apply(
            bodyColor: Colors.black, // Default color for all text
            displayColor: Colors.black, // Default color for all display text
          ),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey), // Color for enabled underline
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.blue), // Color for focused underline
            ),
          ),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
