/**
 * signup.router.dart
 * Navigation handler for signup stage
 */

import 'package:flutter/material.dart';
import 'package:oshinstar/modules/authentication/screens/birth_gender.dart';
import 'package:oshinstar/modules/authentication/screens/categories_picker.dart';
import 'package:oshinstar/modules/authentication/screens/email_verification.dart';
import 'package:oshinstar/modules/authentication/screens/first_last_name.dart';
import 'package:oshinstar/modules/authentication/screens/phone_number.dart';
import 'package:oshinstar/modules/landing/landing_screen.dart';

abstract class SignupRouter {
  // Validates missing user params for the signup stage and redirects accordingly
  static Future<void> route(BuildContext context, Map<String, dynamic> params) async {
    if (!params.containsKey('firstName') ||
        params['firstName'] == null ||
        params['firstName'].isEmpty ||
        !params.containsKey('lastName') ||
        params['lastName'] == null ||
        params['lastName'].isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FirstLastNameScreen()),
      );
      return;
    }

    if (!params.containsKey('gender') ||
        params['gender'] == null ||
        params['gender'].isEmpty ||
        !params.containsKey('birthdate') ||
        params['birthdate'] == null ||
        params['birthdate'].isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BirthGenderScreen()),
      );
      return;
    }

    if (!params.containsKey('phone') ||
        params['phone'] == null ||
        params['phone'].isEmpty ||
        !params.containsKey('isPhoneVerified') ||
        params['isPhoneVerified'] == null ||
        !params['isPhoneVerified']) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const PhoneNumberScreen(
                  returning: true,
                  phone: "",
                )),
      );
      return;
    }

    if (!params.containsKey('isEmailVerified') ||
        params['isEmailVerified'] == null ||
        !params['isEmailVerified']) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EmailVerification(
                  email: '',
                )),
      );
      return;
    }

    if (!params.containsKey('location') ||
        params['location'] == null ||
        params['location'].isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EmailVerification(
                  email: '',
                )),
      );
      return;
    }

    if (!params.containsKey('categories') ||
        params['categories'] == null ||
        (params['categories'] is List && params['categories'].isEmpty)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CategoriesPickerPage()),
      );
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => LandingScreen()));
  }
}
