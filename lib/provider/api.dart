import 'package:belo_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class Api {
  static const domain = 'http://192.168.1.6:8000';

  static Future<dynamic> signUp(String phonenumber, password, username) async {
    final url = Uri.parse('$domain/api/v1/users/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phonenumber': phonenumber,
          'password': password,
          'username': username
        }),
      );
      if (response.statusCode >= 400) {
        throw HttpException('Signup failed!');
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> login(String phonenumber, password) async {
    final url = Uri.parse('$domain/api/v1/users/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phonenumber': phonenumber, 'password': password}),
      );

      final decodedResponse = json.decode(response.body);
      if (response.statusCode >= 400) {
        throw HttpException('Login failed!');
      }
      return decodedResponse;
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> chatWithBot(String token, message) async {
    final url = Uri.parse('$domain/api/gateway/medical-chatbot/chat');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'message': message,
        }),
      );

      if (response.statusCode >= 400) {
        throw HttpException('Signup failed!');
      }

      final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> getUserInfo(String token) async {
    final url = Uri.parse('$domain/api/v1/users/show');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode >= 400) {
        throw HttpException('Something went wrong!');
      }

      final decodedResponse = json.decode(utf8.decode(response.bodyBytes));

      return decodedResponse;
    } catch (error) {
      rethrow;
    }
  }
}
