import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  static final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  // ─── LOGIN ─────────────────────────────────────────────────────────────────
  /// Authenticates user against Firebase Auth Database
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Authenticate with Firebase Authentication
      final fb.UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fb.User? user = credential.user;
      if (user == null) {
        throw Exception("Authentication completed but user object is null.");
      }

      // 2. Extract Firebase JWT ID Token
      final String idToken = await user.getIdToken() ?? '';

      // 3. Map user details to standard map format to maintain compatibility with other UI components
      final userData = {
        "id": user.uid.hashCode,
        "uid": user.uid,
        "name": user.displayName ?? email.split('@')[0],
        "email": user.email ?? email,
        "role": "General User",
      };

      final response = {
        "status": "success",
        "message": "Login successful",
        "data": {
          "token": idToken,
          "user": userData,
        }
      };

      // 4. Cache credentials locally inside SharedPreferences
      await ApiService.saveToken(idToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(userData));

      return response;
    } catch (e) {
      debugPrint("Firebase Login error: $e");
      rethrow;
    }
  }

  // ─── REGISTER ──────────────────────────────────────────────────────────────
  /// Registers a new user into the Firebase Auth Database
  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    required String password,
    String role = "General User",
  }) async {
    try {
      // 1. Register account in Firebase Database
      final fb.UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fb.User? user = credential.user;
      if (user == null) {
        throw Exception("Registration completed but user object is null.");
      }

      // 2. Set user's full name inside Firebase profile
      final String fullName = "$firstName $lastName".trim();
      await user.updateDisplayName(fullName);

      // 3. Extract Firebase JWT ID Token
      final String idToken = await user.getIdToken() ?? '';

      // 4. Map registered user details
      final userData = {
        "id": user.uid.hashCode,
        "uid": user.uid,
        "name": fullName,
        "email": email,
        "phone": phone ?? '',
        "role": role,
      };

      final response = {
        "status": "success",
        "message": "Registration successful",
        "data": {
          "token": idToken,
          "user": userData,
        }
      };

      // 5. Cache details locally
      await ApiService.saveToken(idToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(userData));

      return response;
    } catch (e) {
      debugPrint("Firebase Register error: $e");
      rethrow;
    }
  }

  // ─── LOGOUT ────────────────────────────────────────────────────────────────
  /// Signs out user from active Firebase database session
  static Future<void> logout() async {
    await _auth.signOut();
    await ApiService.clearToken();
  }

  // ─── GET CURRENT USER ──────────────────────────────────────────────────────
  /// Retrieves the active logged-in user profile
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('user_data');
    if (userData == null) {
      // Fallback: consult active firebase authentication state
      final fb.User? fbUser = _auth.currentUser;
      if (fbUser != null) {
        return {
          "id": fbUser.uid.hashCode,
          "uid": fbUser.uid,
          "name": fbUser.displayName ?? fbUser.email?.split('@')[0] ?? '',
          "email": fbUser.email ?? '',
          "role": "General User",
        };
      }
      return null;
    }
    return jsonDecode(userData) as Map<String, dynamic>;
  }

  // ─── IS LOGGED IN ──────────────────────────────────────────────────────────
  /// Determines if the user is authenticated in the Firebase database
  static Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }
}
