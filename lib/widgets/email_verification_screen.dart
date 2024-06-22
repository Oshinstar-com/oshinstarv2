import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/helpers/http.dart';
import 'package:oshinstar/helpers/router.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/account_type.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/widgets/error_snackbar.dart';
import 'package:oshinstar/widgets/pin_code_fields.dart';
import 'package:websafe_svg/websafe_svg.dart';

class InternalEmailVerification extends StatefulWidget {
  const InternalEmailVerification({super.key, required this.email});

  final String email;

  @override
  State<InternalEmailVerification> createState() =>
      _InternalEmailVerificationState();
}

class _InternalEmailVerificationState extends State<InternalEmailVerification> {
  @override
  void initState() {
    final user = context.read<UserCubit>().state;

    sendEmailCode(user);
    super.initState();
  }

  void sendEmailCode(Map<String, dynamic> user) async {
    final email = user["email"].toString();
    final userId = user["userId"].toString();
    final response = await AuthenticationApi.sendEmailCode(
        {"email": email, "userId": userId});

    if (response["statusCode"] != 200) {
      showErrorSnackbar(context, "Internal Server Error. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify your email"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text:
                      'Please verify your account by entering below the code sent to: ',
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.email,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              NumberPinCodeField(
                key: const ValueKey('code-email-input'),
                onChanged: (context, code) async {
                  if (code.length == 6) {
                    final response = await AuthenticationApi.validateEmail(
                        {"userId": user["userId"], "token": code});

                    context
                        .read<UserCubit>()
                        .setUserInfo({"isEmailVerified": true});

                    if (response["statusCode"] == 200) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showSuccessSnackbar(
                          context, "Email verified successfully");
                    } else {
                      showErrorSnackbar(
                          context, "Invalid code. Please try again.");
                    }
                  }
                },
                length: 6,
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {
                  sendEmailCode(user);
                },
                child: const Text('Didn\'t get it? Resend the code now'),
              ),
              const Spacer(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
