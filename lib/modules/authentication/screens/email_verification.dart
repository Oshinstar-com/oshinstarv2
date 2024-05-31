import 'package:flutter/material.dart';
import 'package:oshinstar/modules/authentication/screens/account_type.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/widgets/pin_code_fields.dart';
import 'package:websafe_svg/websafe_svg.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              WebsafeSvg.asset('assets/check.svg'),
              const SizedBox(height: 40),
              const Text(
                'Congratulations',
                style: TextStyle(color: OshinPalette.blue),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your account has been created',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                'You\'re just one step away from joining the community.',
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text:
                      'Please verify your account by entering below the code sent to: ',
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: email,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const NumberPinCodeField(
                key: ValueKey('code-email-input'),
                length: 6,
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {},
                child: const Text('Didn\'t get it? Resend the code now'),
              ),
              const Spacer(),
              const Text('Or'),
              const SizedBox(height: 30),
              ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: OshinPalette.white,
                  backgroundColor: OshinPalette.blue,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountTypeScreen()));
                },
                child: const Text('Let\'s start to build your portfolio'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
