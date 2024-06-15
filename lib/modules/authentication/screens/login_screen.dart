import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/modules/home/screens/home.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final String email;

  const LoginScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/oshinstar-text-logo.png", width: 150),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 5),
                Text(
                  "Welcome back, $email",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () => null,
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: OshinPalette.blue),
                )),
            TextButton(
                onPressed: () => null,
                child: Text("Contact Support",
                    style: TextStyle(color: OshinPalette.blue))),
            const Spacer(),
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final email = this.email;
                    final password = passwordController.text;

                    final response =
                        await AuthenticationApi.login(email, password);

                    if (response.containsKey('token')) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('token', response['token']);
                      prefs.setString('refreshToken', response['refreshToken']);

                      context.read<UserCubit>().setUserInfo(response["user"]);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    } else {
                      // Handle login failure
                      print('Login failed: ${response}');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OshinPalette.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text("Continue"),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
