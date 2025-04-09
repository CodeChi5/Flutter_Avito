import 'dart:convert';

import 'package:http/http.dart' as http;

class UserRepo {
  Future<String> SendCodeRegisterSendCode(String number) async {
    final url = Uri.parse("http://127.0.0.1:8000/api/send-code/");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"phone_number": number});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.body; // Handle response accordingly
    } else {
      throw Exception("Failed to send code");
    }
  }

  Future<String> VerifyCodeRegisterSendCode(String number, String code) async {
    final url = Uri.parse("http://127.0.0.1:8000/api/verify-code/");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"phone_number": number, "code": code});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.body; // Handle response accordingly
    } else {
      throw Exception("Failed to send code");
    }
  }
}
