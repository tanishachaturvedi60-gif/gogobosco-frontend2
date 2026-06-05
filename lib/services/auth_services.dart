import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api_service.dart';

class AuthService {
  // Supabase client (assumes Supabase.initialize has been called in main())
  static final SupabaseClient _client = Supabase.instance.client;

  // ─── LOGIN ─────────────────────────────────────────────────────────────────
  /// Authenticates user using email & password via Supabase.
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final Session? session = response.session;
      if (session == null) {
        throw Exception('Supabase login failed: session is null');
      }

      final User? user = response.user;
      final userData = {
        "id": user?.id.hashCode,
        "uid": user?.id,
        "name": user?.userMetadata?['full_name'] ?? email.split('@')[0],
        "email": user?.email ?? email,
        "role": user?.userMetadata?['role'] ?? 'General User',
      };

      // Cache token and user data
      await ApiService.saveToken(session.accessToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(userData));

      return {
        "status": "success",
        "message": "Login successful",
        "data": {"token": session.accessToken, "user": userData},
      };
    } catch (e) {
      debugPrint('Supabase login error: $e');
      rethrow;
    }
  }

  // ─── REGISTER ──────────────────────────────────────────────────────────────
  /// Registers a new user via Supabase.
  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    required String password,
    String role = "General User",
  }) async {
    try {
      final AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "full_name": "$firstName $lastName",
          "phone": phone ?? "",
        },
      );

      final Session? session = response.session;
      if (session == null) {
        throw Exception('Supabase registration failed: session is null');
      }

      final User? user = response.user;
      final userData = {
        "id": user?.id.hashCode,
        "uid": user?.id,
        "name": user?.userMetadata?['full_name'] ?? "$firstName $lastName",
        "email": user?.email ?? email,
        "phone": phone ?? "",
      };

      // Cache token and user data
      await ApiService.saveToken(session.accessToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(userData));

      return {
        "status": "success",
        "message": "Registration successful",
        "data": {"token": session.accessToken, "user": userData},
      };
    } catch (e) {
      debugPrint('Supabase register error: $e');
      rethrow;
    }
  }

  // ─── LOGOUT ────────────────────────────────────────────────────────────────
  /// Signs out the current Supabase session.
  static Future<void> logout() async {
    await _client.auth.signOut();
    await ApiService.clearToken();
  }

  // ─── GOOGLE SIGN-IN ────────────────────────────────────────────────────────
  /// Initiates Google OAuth via Supabase using native Google Sign-In.
  static Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final bool success = await _client.auth.signInWithOAuth(OAuthProvider.google);
        if (!success) {
          throw Exception('Google sign-in failed');
        }

        final Session? session = _client.auth.currentSession;
        if (session == null) {
          throw Exception('Google sign-in failed: session is null');
        }

        final User? user = _client.auth.currentUser;
        final userData = {
          "id": user?.id.hashCode,
          "uid": user?.id,
          "name": user?.userMetadata?['full_name'] ?? user?.email?.split('@')[0] ?? '',
          "email": user?.email ?? '',
          "role": user?.userMetadata?['role'] ?? 'General User',
        };

        await ApiService.saveToken(session.accessToken);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(userData));

        return {
          "status": "success",
          "message": "Google sign‑in successful",
          "data": {"token": session.accessToken, "user": userData},
        };
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          throw Exception('Google sign-in aborted by user');
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final String? idToken = googleAuth.idToken;
        final String? accessToken = googleAuth.accessToken;

        if (idToken == null) {
          throw Exception('No ID Token found.');
        }

        final AuthResponse response = await _client.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );

        final Session? session = response.session;
        if (session == null) {
          throw Exception('Google sign-in failed: session is null');
        }

        final User? user = response.user;
        final userData = {
          "id": user?.id.hashCode,
          "uid": user?.id,
          "name": user?.userMetadata?['full_name'] ?? user?.email?.split('@')[0] ?? '',
          "email": user?.email ?? '',
          "role": user?.userMetadata?['role'] ?? 'General User',
        };

        await ApiService.saveToken(session.accessToken);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(userData));

        return {
          "status": "success",
          "message": "Google sign‑in successful",
          "data": {"token": session.accessToken, "user": userData},
        };
      }
    } catch (e) {
      debugPrint('Google sign‑in error: $e');
      rethrow;
    }
  }

  // ─── APPLE SIGN-IN ────────────────────────────────────────────────────────
  /// Initiates Apple Sign-In via Supabase.
  static Future<Map<String, dynamic>> signInWithApple() async {
    try {
      final bool success = await _client.auth.signInWithOAuth(OAuthProvider.apple);

      if (!success) {
        throw Exception('Apple sign-in failed');
      }

      final Session? session = _client.auth.currentSession;
      if (session == null) {
        throw Exception('Apple sign-in failed: session is null');
      }

      final User? user = _client.auth.currentUser;
      final userData = {
        "id": user?.id.hashCode,
        "uid": user?.id,
        "name": user?.userMetadata?['full_name'] ?? user?.email?.split('@')[0] ?? 'Apple User',
        "email": user?.email ?? '',
        "role": user?.userMetadata?['role'] ?? 'General User',
      };

      await ApiService.saveToken(session.accessToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(userData));

      return {
        "status": "success",
        "message": "Apple sign‑in successful",
        "data": {"token": session.accessToken, "user": userData},
      };
    } catch (e) {
      debugPrint('Apple sign‑in error: $e');
      rethrow;
    }
  }

  // ─── GET CURRENT USER ──────────────────────────────────────────────────────
  /// Retrieves the active logged‑in Supabase user profile.
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final Session? session = _client.auth.currentSession;
    if (session == null) return null;
    final User? user = _client.auth.currentUser;
    if (user == null) return null;
    return {
      "id": user.id.hashCode,
      "uid": user.id,
      "name": user.userMetadata?['full_name'] ?? user.email?.split('@')[0] ?? '',
      "email": user.email ?? '',
      "role": user.userMetadata?['role'] ?? 'General User',
    };
  }

  // ─── IS LOGGED IN ──────────────────────────────────────────────────────────
  /// Determines if a Supabase session exists.
  static Future<bool> isLoggedIn() async {
    return _client.auth.currentSession != null;
  }
}
