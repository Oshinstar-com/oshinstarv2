import 'package:flutter/material.dart';
import 'package:oshinstar/modules/authentication/phone_verification_screen.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class UserDetailsSignupScreen extends StatefulWidget {
  const UserDetailsSignupScreen({super.key});

  @override
  _UserDetailsSignupScreenState createState() =>
      _UserDetailsSignupScreenState();
}

class _UserDetailsSignupScreenState extends State<UserDetailsSignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  DateTime? selectedBirthdate;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthdate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = DateTime(now.year - 13, now.month, now.day);
    final DateTime firstDate = DateTime(now.year - 100);
    final DateTime lastDate = DateTime(now.year - 13, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != selectedBirthdate) {
      setState(() {
        selectedBirthdate = picked;
      });
    }
  }

  void _printUserDetails() {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String birthdate = selectedBirthdate != null
        ? "${selectedBirthdate!.toLocal()}".split(' ')[0]
        : "Not selected";
    final String gender = selectedGender ?? "Not selected";

    print("First Name: $firstName");
    print("Last Name: $lastName");
    print("Birthdate: $birthdate");
    print("Gender: $gender");
  }

  void _showGenderPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feeling not included?'),
          content: Text("Don't worry, you will be able to customize later."),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok, got it',
                style: TextStyle(color: OshinPalette.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Fill in your details'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
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
                    const SizedBox(height: 50),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Choose your gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "It allows us to match you to potential Talents or Business \ninterested in your profile")
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.female),
                      title: const Text("Female"),
                      trailing: selectedGender == "Female"
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedGender = "Female";
                        });
                        _showGenderPopup(context);
                      },
                      selected: selectedGender == "Female",
                    ),
                    ListTile(
                      leading: const Icon(Icons.male),
                      title: const Text("Male"),
                      trailing: selectedGender == "Male"
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedGender = "Male";
                        });
                        _showGenderPopup(context);
                      },
                      selected: selectedGender == "Male",
                    ),
                    const SizedBox(height: 50),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Add your birthdate",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "It allows us to match you to potential Talents or Business \ninterested in your profile")
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.cake_outlined),
                      title: Text(
                        selectedBirthdate == null
                            ? "Birthdate"
                            : "${selectedBirthdate!.toLocal()}".split(' ')[0],
                      ),
                      onTap: () => _selectBirthdate(context),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(),
                    ),
                    SafeArea(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _printUserDetails();
                            Navigator.push(context, MaterialPageRoute(builder: (_) => PhoneVerificationSignup()));

                          },
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
            ),
          );
        },
      ),
    );
  }
}
