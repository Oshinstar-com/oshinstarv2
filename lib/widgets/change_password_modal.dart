import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/widgets/error_snackbar.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({Key? key}) : super(key: key);

  @override
  _ChangePasswordModalState createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state;

    return Scaffold(
      body: SingleChildScrollView(
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
                      'Change Password',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 16),
              const Text(
                "Choose a strong password and do not reuse it for other accounts. ",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton(
                    onPressed: () {}, // Add link functionality
                    child: const Text(
                      "Learn more",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Changing your password will disconnect you from all your devices, including your phone. You will need to enter your new password on all your devices.",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _newPasswordController,
                obscureText: !_showNewPassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showNewPassword = !_showNewPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Use at least 8 characters. Don't use a password from another site, or something too obvious.",
                style: TextStyle(fontSize: 14),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {}, // Add link functionality
                    child: const Text(
                      "Why?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm new password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  final newPassword = _newPasswordController.text;
                  final confirmPassword = _confirmPasswordController.text;
      
                  if (newPassword != confirmPassword) {
                    showErrorSnackbar(context, "Passwords don't match");
                    return;
                  }
      
                  final response = await AuthenticationApi.updatePassword({
                    "userId": user["userId"],
                    "newPassword": newPassword,
                  });
      
                  if (response["statusCode"] == 200) {
                    // Handle successful password change
                    Navigator.of(context).pop();
                    showSuccessSnackbar(
                        context, "Password updated successfully");
                  } else {
                    // Handle error
                    print('Failed to change password');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: OshinPalette.blue,
                  foregroundColor: OshinPalette.white
                ),
                child: const Text("CHANGE PASSWORD"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
