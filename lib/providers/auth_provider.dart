import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  static const String baseUrl = 'http://192.168.0.104:5000';
  String _jwt = '';
  String _username = '';
  Future<bool> signUp(String username, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/api/auth/signup'),
        body: json.encode({
          'username': username,
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
    print('Made sign in call');
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

  String get jwt {
    String newJwt = _jwt;
    return newJwt;
  }

  String get username {
    String newUsername = _username;
    return newUsername;
  }
}