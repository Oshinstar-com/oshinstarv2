import 'package:flutter/material.dart';
import 'package:oshinstar/modules/authentication/create_account.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class EmailScreenSignup extends StatefulWidget {
  EmailScreenSignup({super.key});

  @override
  _EmailScreenSignupState createState() => _EmailScreenSignupState();
}

class _EmailScreenSignupState extends State<EmailScreenSignup> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
  }

  void _validateEmail() {
    final email = emailController.text;
    setState(() {
      isEmailValid = _isValidEmail(email);
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Welcome to Oshinstar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 5),
                Text(
                  "Log in or sign up with your email",
                  style: TextStyle(fontSize: 19),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: UnderlineInputBorder(),
              ),
            ),
            if (!isEmailValid)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please enter a valid email',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const Spacer(),
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => isEmailValid
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CreateAccountSignupScreen(
                                    email: emailController.text,
                                  )))
                      : null,
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
