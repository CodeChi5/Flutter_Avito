import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final String baseUrl = 'http://192.168.84.57:8000/api';
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  Future<bool> sendPhoneVerification(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send-code/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'Code sent';
      }

      return false;
    } catch (e) {
      print('Error sending verification code: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> verifyPhoneCode(
      String phoneNumber, String code) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-code/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone_number': phoneNumber,
          'code': code,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'Authenticated') {
        // Save token and user ID
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, data['token']);
        await prefs.setInt(_userIdKey, data['user_id']);

        return {
          'success': true,
          'token': data['token'],
          'userId': data['user_id'],
        };
      } else {
        return {
          'success': false,
          'error': data['error'] ?? 'Verification failed',
        };
      }
    } catch (e) {
      print('Error verifying code: $e');
      return {
        'success': false,
        'error': 'Network error occurred',
      };
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
  }
}
