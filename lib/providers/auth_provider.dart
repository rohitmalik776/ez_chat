import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class AuthProvider with ChangeNotifier {
  String? _jwt;
  String? _username;
  Future<bool> signUp(String username, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/api/auth/signup/'),
        body: json.encode({
          'username': username,
          // TODO: Improve password security
          'password': password,
        }));
    final decodedResponse = json.decode(response.body) as Map<String, Object?>;
    try {
      if (decodedResponse['loginStatus'] == 'success') {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> signIn(String username, String password) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/api/auth/signin/'),
          body: json.encode({
            'username': username,
            'password': password,
          }));
      Map<String, dynamic> decodedData = json.decode(response.body);

      if (decodedData['loginStatus'].toString() == 'success') {
        _jwt = decodedData['jwt'];
        _username = decodedData['username'];
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  void signOut() {
    _jwt = null;
    _username = null;
  }

  String? get jwt => _jwt;

  String? get username => _username;
}
