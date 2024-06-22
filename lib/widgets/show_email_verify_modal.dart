import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/helpers/router.dart';
import 'package:oshinstar/modules/authentication/screens/email_verification.dart';
import 'package:oshinstar/widgets/email_verification_screen.dart';
import 'package:oshinstar/widgets/gray_container.dart';

class VerifyEmailModal extends StatefulWidget {
  final bool verified;

  const VerifyEmailModal({super.key, required this.verified});

  @override
  _VerifyEmailModalState createState() => _VerifyEmailModalState();
}

class _VerifyEmailModalState extends State<VerifyEmailModal> {
  String? selectedVisibility;

  void updateVisibility(String? visibility) {
    setState(() {
      selectedVisibility = visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Expanded(
                  child: Text(
                    'Email Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: Text(user["email"]),
              subtitle: widget.verified
                  ? null
                  : const Text("Email address is not verified"),
            ),
            Visibility(
              visible: !widget.verified,
              child: Column(
                children: [
                  const GrayContainer(
                      title:
                          "Oshinstar's best users verify their email \naddress."),
                  const GrayContainer(
                      title:
                          "To resend the confirmation, click the \nbutton below."),
                  TextButton(
                    onPressed: () {
                      AppRouter.route(
                          context, InternalEmailVerification(email: user["email"]));
                    },
                    child: const Text("Resend confirmation"),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.verified,
              child: DropdownButton<String>(
                hint: const Text("Select visibility"),
                value: selectedVisibility,
                items: [
                  DropdownMenuItem<String>(
                    value: "Anyone on Oshinstar",
                    child: Container(
                      width: MediaQuery.of(context).size.width -
                          96, // Adjust width as necessary
                      child: const ListTile(
                        leading: Icon(Icons.star_outline_sharp),
                        title: Text("Anyone on Oshinstar"),
                      ),
                    ),
                  ),
                ],
                onChanged: updateVisibility,
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
