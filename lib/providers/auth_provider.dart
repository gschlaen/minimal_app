import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:minimal_app/global/environment.dart';
import 'package:minimal_app/models/models.dart';

class AuthProvider extends ChangeNotifier {
  late User usuario;
  bool _authenticating = false;

  final _storage = const FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;
    final data = {
      'email': 'email',
      'password': 'password',
    };
    final resp = await http.post(Uri.parse('${Environment.baseUrl}/mia-auth/login'), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    final loginResponse = LoginResponse.fromJson(resp.body);
    authenticating = false;

    if (loginResponse.success) {
      await _saveToken(loginResponse.user!.accessToken);
      return true;
    } else {
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';

    if (token != '') {
      return true;
    } else {
      return false;
    }
  }

  logout() async {
    await _storage.delete(key: 'token');
    return;
  }
}
