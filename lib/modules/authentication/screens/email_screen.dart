import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/models/User.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/create_account.dart';
import 'package:oshinstar/modules/authentication/cubit/authentication_cubit.dart';
import 'package:oshinstar/modules/authentication/screens/login_screen.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:websafe_svg/websafe_svg.dart';

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

  // Method to handle the button press
  Future<void> _handleContinuePressed(Map<String, dynamic> user) async {
    final userId = user['userId'];

    if (isEmailValid) {
      final response =
          await AuthenticationApi.checkEmail({"email": emailController.text});

      if (response["statusCode"] == 404) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                CreateAccountSignupScreen(email: emailController.text),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(email: emailController.text),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

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
                  onPressed: () {
                    if (isEmailValid) {
                      _handleContinuePressed(user);
                    }
                  },
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
