import 'package:http/http.dart';
import 'package:oshinstar/helpers/http.dart';

abstract class AuthenticationApi {
  static Future<Map<String, dynamic>> updateUser(Map<String, dynamic> body) async {
    final response = await Http.post('v1/user', body);

    return response;
  }

  static Future<Map<String, dynamic>> checkEmail(Map<String, dynamic> body) async {
    final response = await Http.post('v1/user/email_exists', body);


    return response;
  }

  static Future<Map<String, dynamic>> getUser(String userId) async {
    final response = await Http.get('v1/user/$userId');

    return response["body"];
  }

  static Future<Map<String, dynamic>> sendPhoneCode(Map<String, dynamic> body) async {
    final response = await Http.post('v1/phone/verification', body);

    return response;
  }

  static Future<Map<String, dynamic>> validatePhoneCode(Map<String, dynamic> body) async {
    final response = await Http.post('v1/phone/validate', body);

    return response;
  }
}