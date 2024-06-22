import 'package:oshinstar/helpers/http.dart';

abstract class AuthenticationApi {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
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

  static Future<Map<String, dynamic>> getUser(String userId) async {
    final response = await Http.get('v1/user/$userId');

    return response["body"];
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

  static Future<Map<String, dynamic>> sendEmailCode(Map<String, dynamic> body) async {
    final response = await Http.post('v1/verify_email', body);

    return response;
  }

   static Future<Map<String, dynamic>> validateEmail(Map<String, dynamic> body) async {
    final response = await Http.post('v1/validate_email', body);

    return response;
  }


  static Future<Map<String, dynamic>> updatePassword(Map<String, dynamic> body) async {
    final response = await Http.post('v3/auth/update_password', body);

    return response;
  } 

   static Future<Map<String, dynamic>> updateBirthdate(Map<String, dynamic> body) async {
    final response = await Http.post('v1/user/update_birthdate', body);

    return response;
  } 
}
