import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/birth_gender.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class FirstLastNameScreen extends StatefulWidget {
  const FirstLastNameScreen({super.key});

  @override
  _FirstLastNameScreenState createState() => _FirstLastNameScreenState();
}

class _FirstLastNameScreenState extends State<FirstLastNameScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    _getUserIdFromHive();
  }

  Future<void> _getUserIdFromHive() async {
    final box = await Hive.openBox('userBox');
    setState(() {
      userId = box.get('userId');
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void _saveData() async {
    if (userId != null) {
      final String firstName = firstNameController.text;
      final String lastName = lastNameController.text;

      final response = await AuthenticationApi.updateUser(
          {"userId": userId, "firstName": firstName, "lastName": lastName});

          print(response);
          
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BirthGenderScreen()),
      );
    } else {
      // Handle the case where userId is null (e.g., show an error message)
      print('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,

        title: const Text('Fill in your details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: UnderlineInputBorder(),
              ),
            ),
            const Spacer(),
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _saveData,
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
