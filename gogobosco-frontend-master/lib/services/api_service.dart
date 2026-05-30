import 'dart:convert';
import 'package:gogobosco/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Base URL — change to your server IP/domain before production
// Base URL is now defined in core/constants.dart
const String baseUrl = "http://localhost:8080/api";


class ApiService {
  // ─── Token Storage ─────────────────────────────────────────────────────────
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_data');
  }

  // ─── Base Headers ──────────────────────────────────────────────────────────
  static Future<Map<String, String>> _headers({bool auth = false}) async {
    final headers = <String, String>{"Content-Type": "application/json"};
    if (auth) {
      final token = await getToken();
      if (token != null) headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  // ─── Response Parser ───────────────────────────────────────────────────────
  static Map<String, dynamic> _parse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }
    throw ApiException(
      statusCode: response.statusCode,
      message: body['message'] ?? "Something went wrong",
    );
  }

  // ─── POST ──────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    bool auth = false,
  }) async {
    final url = Uri.parse("$kBaseUrl$endpoint");
    final response = await http.post(
      url,
      headers: await _headers(auth: auth),
      body: jsonEncode(data),
    );
    return _parse(response);
  }

  // ─── GET ───────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    bool auth = false,
    Map<String, String>? queryParams,
  }) async {
    var url = Uri.parse("$kBaseUrl$endpoint");
    if (queryParams != null) {
      url = url.replace(queryParameters: queryParams);
    }
    final response = await http.get(url, headers: await _headers(auth: auth));
    return _parse(response);
  }

  // ─── PUT ───────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse("$kBaseUrl$endpoint");
    final response = await http.put(
      url,
      headers: await _headers(auth: true),
      body: jsonEncode(data),
    );
    return _parse(response);
  }

  // ─── PATCH ─────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    final url = Uri.parse("$kBaseUrl$endpoint");
    final response = await http.patch(
      url,
      headers: await _headers(auth: true),
      body: data != null ? jsonEncode(data) : null,
    );
    return _parse(response);
  }

  // ─── DELETE ────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final url = Uri.parse("$kBaseUrl$endpoint");
    final response = await http.delete(
      url,
      headers: await _headers(auth: true),
    );
    return _parse(response);
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  const ApiException({required this.statusCode, required this.message});

  @override
  String toString() => message;
}
