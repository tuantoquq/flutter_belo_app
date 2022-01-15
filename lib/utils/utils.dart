import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

class Util {
  static InputDecoration getCustomDecoration(
      String hint, Widget? icon, BuildContext context) {
    var _tmpBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(45),
      borderSide: const BorderSide(color: Colors.white),
    );

    return InputDecoration(
      focusedBorder: _tmpBorder,
      disabledBorder: _tmpBorder,
      errorBorder: _tmpBorder,
      focusedErrorBorder: _tmpBorder,
      enabledBorder: _tmpBorder,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      prefixIcon: icon,
      hintText: hint,
      filled: true,
      fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
    );
  }

  static void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      ),
    );
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = json.decode(prefs.getString("userData")!)["token"];
    return token;
  }

  static String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
