import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oshinstar/modules/authentication/email_verification.dart';
import 'package:oshinstar/widgets/pin_code_fields.dart';

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  Timer? _timer;
  var _start = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (_) {
      if (_start == 0) {
        _timer?.cancel();
        return;
      }
      setState(() {
        _start--;
      });
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your code'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'We just sent a code to your phone number. Enter it below.'),
              const SizedBox(height: 20),
              Visibility(
                visible: _start != 0,
                child: Text(
                    'If you didn\'t receive the code, you can resend it on: $timerText'),
              ),
              Visibility(
                visible: _start != 0,
                child: const SizedBox(height: 20),
              ),
              // Text(widget.phoneNumber),
              const Text('+18091111111'),
              const SizedBox(height: 20),
              NumberPinCodeField(
                onChanged: (context, code) {
                  if (code.length == 6) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmailVerification(email: 'bueno@yopmail.com'),
                      ),
                    );
                  }
                },
                key: ValueKey('code-input'),
                length: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: _start == 100 || _start == 0,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      child: const Text('Call me'),
                    ),
                  ),
                  Visibility(
                    visible: _start == 0,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      child: const Text('Edit phone number/Resend code'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
