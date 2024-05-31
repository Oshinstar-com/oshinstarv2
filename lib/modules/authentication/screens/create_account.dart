import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oshinstar/helpers/hive.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/first_last_name.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateAccountSignupScreen extends StatefulWidget {
  final String email;

  const CreateAccountSignupScreen({super.key, required this.email});

  @override
  _CreateAccountSignupScreenState createState() =>
      _CreateAccountSignupScreenState();
}

class _CreateAccountSignupScreenState extends State<CreateAccountSignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  
  final UserHiveManager hiveManager = UserHiveManager();

  bool isEmailValid = true;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
    emailController.text = widget.email;
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
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    const url = "https://hub.oshinstar.com";

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _handleContinuePressed() async {
    final response = await AuthenticationApi.updateUser({
      "email": emailController.text,
      "password": passwordController.text
    });

    final userId = response["body"]["userId"];
    hiveManager.writeDataToBox('userBox','userId', userId);
    hiveManager.writeDataToBox('userBox','email', emailController.text);

    print(response["body"]);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const FirstLastNameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Create a Free account now'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your e-mail address',
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
            const SizedBox(height: 20),
            TextField(
              obscureText: !isPasswordVisible,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Set Login password',
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: OshinPalette.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text.rich(
              TextSpan(
                text:
                    'By signing up, you certify that you are at least 13 years old, or you have reached the minimum age limit set out in the laws of your country of residence, and accept Oshinstar\'s: ',
                style: const TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Terms & Data Policy',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _launchUrl,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _handleContinuePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OshinPalette.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text("Continue"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
