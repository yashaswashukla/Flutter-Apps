import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _autheticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyCD_sEhp2vBEJMdOOuh8ul9vDY4pqWZ2l4');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _autheticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _autheticate(email, password, 'signInWithPassword');
  }
}
