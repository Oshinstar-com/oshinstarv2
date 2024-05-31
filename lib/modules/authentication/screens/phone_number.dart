import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:oshinstar/helpers/hive.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'dart:convert';

import 'package:oshinstar/modules/authentication/screens/phone_verification.dart';

class PhoneNumberScreen extends StatefulWidget {
  final bool returning;
  final String? phone;

  const PhoneNumberScreen({super.key, required this.returning, required this.phone});

  @override
  _PhoneNumberScreenState createState() =>
      _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String _countryCode = "+1";
  String? _countryFlag;
  String _phoneNumber = "";


  final bool _showGetHelp = false;
  final bool _showLogOut = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final url =
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${position.latitude}&longitude=${position.longitude}&localityLanguage=en';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _countryCode = data['countryCode'] ?? "+1";
        _countryFlag = CountryCode.fromCode(_countryCode).flagUri;
      });
    } else {
      throw Exception('Failed to load country code');
    }
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      _countryCode = countryCode.dialCode ?? "+1";
      _countryFlag = countryCode.flagUri;
    });
  }

  void _saveData(String phoneNumber) async {
    String userId = await UserHiveManager().getUserId();
    await AuthenticationApi.updateUser({
      "userId": userId,
      "phone": phoneNumber
    });
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
                  _saveData(_phoneNumber);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CodeVerificationScreen(phoneNumber: _phoneNumber.isEmpty ? widget.phone ?? "000" : _phoneNumber,),
                    ),
                  );
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
                    // Implement your verification code sending logic here
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
