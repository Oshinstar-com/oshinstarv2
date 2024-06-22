import 'dart:async';

import 'package:user/src/models/remote_user/user.dart';
import 'package:user/src/utils/http.dart';

class UserBackend {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await Http.post('v1/login', {"email": email, "password": password});
    return response["body"];
  }

  static Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final response = await Http.post('v1/refresh', {"token": refreshToken });

    return response;
  }

  static Future<Map<String, dynamic>> updateUser(
      Map<String, dynamic> body) async {
    final response = await Http.post('v1/user', body);

    return response;
  }

  static Future<Map<String, dynamic>> checkEmail(
      Map<String, dynamic> body) async {
    final response = await Http.post('v1/user/email_exists', body);

    return response;
  }

  static Future<User> getUser(String userId) async {
    final response = await Http.get('v1/user/$userId');
    return User.fromJson(response["body"]);
  }

  static Future<Map<String, dynamic>> sendPhoneCode(
      Map<String, dynamic> body) async {
    final response = await Http.post('v1/phone/verification', body);

    return response;
  }

  static Future<Map<String, dynamic>> validatePhoneCode(
      Map<String, dynamic> body) async {
    final response = await Http.post('v1/phone/validate', body);

    return response;
  }
}
