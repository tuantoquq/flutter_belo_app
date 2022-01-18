import 'package:belo_app/models/chat.dart';
import 'package:belo_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class Api {
  static const domain = 'http://192.168.1.6:8000/api/v1';

  static Future<dynamic> signUp(String phonenumber, password, username) async {
    final url = Uri.parse('$domain/users/register');
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
    final url = Uri.parse('$domain/users/login');
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

  static Future<dynamic> getUserInfo(String token) async {
    final url = Uri.parse('$domain/users/show');
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

  static Future<dynamic> getListFriend(String token) async {
    final url = Uri.parse('$domain/friends/list');
    try {
      final response = await http.post(
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

  // static Future<dynamic> getListRequestedFriend(String token) async {
  //   final url = Uri.parse('$domain/friends/get-requested-friend');
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {'Authorization': 'Bearer $token'},
  //     );

  //     if (response.statusCode >= 400) {
  //       throw HttpException('Something went wrong!');
  //     }
  //     final decodedResponse = json.decode(utf8.decode(response.bodyBytes));

  //     return decodedResponse;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  static Future<dynamic> getFriendProfile(String token, String id) async {
    final url = Uri.parse('$domain/users/show?id=$id');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
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

  static Future<dynamic> getListReceivedFriend(String token) async {
    final url = Uri.parse('$domain/friends/get-requested-friend');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
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

  static Future<dynamic> setAcceptOrRejectFriend(
      String token, String userId, bool isAccept) async {
    final url = Uri.parse('$domain/friends/set-accept');
    try {
      int state = 1;
      if (isAccept == false) {
        state = 2;
      }
      print(userId);
      print(isAccept);
      print(state);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({"user_id": userId, "is_accept": state}),
      );
      if (response.statusCode >= 400) {
        throw HttpException('Set Accept or Reject Friend failed!');
      }
      final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
      print(decodedResponse);
      return decodedResponse;
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> getListMessageCard(String token) async {
    final url = Uri.parse('$domain/chats/getMessaged');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
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

  static Future<dynamic> getListMessagesOfChat(
      String token, String chatId) async {
    final url = Uri.parse('$domain/chats/getMessages?chatId=$chatId');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
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

  static Future<dynamic> sendMessage(String token, MessagesChat messagesChat) async {

    final url = Uri.parse('$domain/chats/send');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "name": messagesChat.receivedName,
          "chatId": messagesChat.chatId,
          "receivedId": messagesChat.receivedId,
          "type": "PRIVATE_CHAT",
          "content": messagesChat.content
        })
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
