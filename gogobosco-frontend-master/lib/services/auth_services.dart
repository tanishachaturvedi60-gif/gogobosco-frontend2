import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  // ─── LOGIN ─────────────────────────────────────────────────────────────────
  /// POST /api/auth/login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post("/auth/login", {
      "email": email,
      "password": password,
    });

    // Save token from response
    final data = response['data'];
    if (data != null && data['token'] != null) {
      await ApiService.saveToken(data['token'] as String);
      // Optionally cache user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(data['user']));
    }

    return response;
  }

  // ─── REGISTER ──────────────────────────────────────────────────────────────
  /// POST /api/auth/register
  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    required String password,
    String role = "general_user",
  }) async {
    final response = await ApiService.post("/auth/register", {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      if (phone != null && phone.isNotEmpty) "phone": phone,
      "password": password,
      "role": role,
    });

    // Save token from response
    final data = response['data'];
    if (data != null && data['token'] != null) {
      await ApiService.saveToken(data['token'] as String);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(data['user']));
    }

    return response;
  }

  // ─── LOGOUT ────────────────────────────────────────────────────────────────
  static Future<void> logout() async {
    await ApiService.clearToken();
  }

  // ─── GET CURRENT USER ──────────────────────────────────────────────────────
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    if (userData == null) return null;
    return jsonDecode(userData) as Map<String, dynamic>;
  }

  // ─── IS LOGGED IN ──────────────────────────────────────────────────────────
  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null && token.isNotEmpty;
  }
}
