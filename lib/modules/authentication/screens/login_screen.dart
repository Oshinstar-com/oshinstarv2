import 'package:flutter/material.dart';
import 'package:oshinstar/utils/themes/palette.dart';

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
                  style: TextStyle(fontSize: 19),
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        OshinPalette.blue, // Blue color for the button
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
