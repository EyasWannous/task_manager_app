// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_authentication/src/models/models.dart';

class AuthenticationClient {
  AuthenticationClient({
    http.Client? httpClient,
    this.baseUrl = 'https://reqres.in/api',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<String?> login(String email, String password) async {
    try {
      final loginRequest = Uri.parse('$baseUrl/login');

      final user = User(email: email, password: password).toJson();

      final response = await httpClient.post(
        loginRequest,
        body: user,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      final registerRequest = Uri.parse('$baseUrl/register');

      final user = User(email: email, password: password).toJson();

      final response = await httpClient.post(
        registerRequest,
        body: user,
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return jsonEncode(result['token']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
