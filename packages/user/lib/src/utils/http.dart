import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class Http {
  static String apiUrl = "https://809e-179-53-44-76.ngrok-free.app";

  static Future<Map<String, dynamic>> post(
      String route, Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse("$apiUrl/api/$route"),
        body: json.encode(body), headers: {'Content-Type': "application/json"});

    return {
      "body": json.decode(response.body),
      "statusCode": response.statusCode
    };
  }

  static Future<Map<String, dynamic>> get(String route) async {
    final response = await http.get(Uri.parse("$apiUrl/api/$route"));

    return {
      "body": json.decode(response.body),
      "statusCode": response.statusCode
    };
  }
}
