import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:oshinstar/helpers/hive.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'dart:convert';

import 'package:oshinstar/modules/authentication/screens/phone_verification.dart';
import 'package:oshinstar/widgets/action_blocked.dart';

class PhoneNumberScreen extends StatefulWidget {
  final bool returning;
  final String? phone;

  const PhoneNumberScreen(
      {super.key, required this.returning, required this.phone});

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String _countryCode = "+1";
  String? _countryFlag;
  String _phoneNumber = "";

  bool _showGetHelp = false;
  bool _showLogOut = false;

  @override
  void initState() {
    super.initState();
  }



  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      _countryCode = countryCode.dialCode ?? "+1";
      _countryFlag = countryCode.flagUri;
    });
  }

  void _saveData(String phoneNumber, String method) async {
    dynamic userId = await HiveManager.readDataFromBox("userBox", "userId");
    
    await AuthenticationApi.updateUser(
        {"userId": userId, "phone": phoneNumber});

    await sendCode(method, userId, phoneNumber);
  }

  /**
   * method = call | sms
   */
  Future<void> sendCode(String method, String userId, String phone) async {
    final response = await AuthenticationApi.sendPhoneCode(
        {"userId": userId, "method": method, "phone": phone});

        print(response["statusCode"]);

    if (response["statusCode"] == 429) {
      print("got here");
      setState(() {
        _showGetHelp = true;
        _showLogOut = true;
      });

      showActionBlockedDialog(context);
    } else {
      print("got here");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CodeVerificationScreen(
            phoneNumber:
                _phoneNumber.isEmpty ? widget.phone ?? "000" : _phoneNumber,
               
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Phone number'),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Hey! We need to verify your account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'To prevent abuse, OshinStar requires you to verify your account through the use of SMS.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please select your country and enter a mobile phone number to generate an authorization code that will be sent to you instantly.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CountryCodePicker(
                  onChanged: _onCountryChange,
                  initialSelection: 'US',
                  favorite: const ['+1', 'US'],
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
                minWidth: 400,
              ),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.chat),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _saveData(
                      _phoneNumber.isEmpty
                          ? widget.phone ?? "000"
                          : _phoneNumber,
                      "sms");
                },
                label: const Text('Send Verification Code'),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: widget.returning,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  minWidth: 400,
                ),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.chat),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _saveData(
                        _phoneNumber.isEmpty
                            ? widget.phone ?? "000"
                            : _phoneNumber,
                        "sms");
                  },
                  label: Text('Send Code again to ${widget.phone}'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: _showGetHelp,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  minWidth: 400,
                ),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.help),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Implement your verification code sending logic here
                  },
                  label: const Text('Get help'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: _showLogOut,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  minWidth: 400,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Log out'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
