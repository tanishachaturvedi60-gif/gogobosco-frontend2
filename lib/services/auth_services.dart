import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

/// Authentication service that talks to the Spring Boot backend.
/// All login/register calls go to /api/auth/* endpoints which issue
/// our custom BCrypt-verified JWT tokens.
class AuthService {
  // ─── LOGIN ─────────────────────────────────────────────────────────────────
  /// Authenticates user via Spring Boot JWT endpoint.
  /// Accepts either a username or email in [usernameOrEmail].
  static Future<Map<String, dynamic>> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    try {
      final response = await ApiService.post(
        '/auth/login',
        {'usernameOrEmail': usernameOrEmail, 'password': password},
      );

      final data = response['data'] as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = data['user'] as Map<String, dynamic>;

      await ApiService.saveToken(token);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(user));

      return response;
    } catch (e) {
      debugPrint('Login error: $e');
      rethrow;
    }
  }

  // ─── REGISTER ──────────────────────────────────────────────────────────────
  /// Registers a new user via Spring Boot endpoint.
  /// New users are assigned the GENERAL role automatically by the backend.
  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    required String password,
  }) async {
    try {
      final response = await ApiService.post(
        '/auth/register',
        {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phone': phone ?? '',
          'password': password,
        },
      );

      final data = response['data'] as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = data['user'] as Map<String, dynamic>;

      await ApiService.saveToken(token);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(user));

      return response;
    } catch (e) {
      debugPrint('Register error: $e');
      rethrow;
    }
  }

  // ─── LOGOUT ────────────────────────────────────────────────────────────────
  /// Clears the stored JWT token and cached user data.
  static Future<void> logout() async {
    await ApiService.clearToken();
  }

  // ─── GET CACHED USER ───────────────────────────────────────────────────────
  /// Reads the last-saved user profile from SharedPreferences.
  static Future<Map<String, dynamic>?> getCachedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('user_data');
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  // ─── FETCH LIVE PROFILE ────────────────────────────────────────────────────
  /// Fetches the current authenticated user's profile from the backend.
  /// Returns null if the user is not logged in or the request fails.
  static Future<Map<String, dynamic>?> fetchProfile() async {
    try {
      final response = await ApiService.get('/users/me', auth: true);
      // Cache the updated profile
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(response));
      return response;
    } catch (e) {
      debugPrint('fetchProfile error: $e');
      return null;
    }
  }

  // ─── IS LOGGED IN ──────────────────────────────────────────────────────────
  /// Returns true if a JWT token is stored in SharedPreferences.
  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }
}
