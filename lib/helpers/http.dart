import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Http {
  static String apiUrl = "https://0798-148-0-89-10.ngrok-free.app";

  static Future<Map<String, dynamic>> post(
      String route, Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse("$apiUrl/$route"),
        body: json.encode(body), headers: {'Content-Type': "application/json"});

    return {
      "body": json.decode(response.body),
      "statusCode": response.statusCode
    };
  }

  static Future<Map<String, dynamic>> get(String route) async {
    final response = await http.get(Uri.parse("$apiUrl/$route"));

    return {
      "body": json.decode(response.body),
      "statusCode": response.statusCode
    };
  }
}
