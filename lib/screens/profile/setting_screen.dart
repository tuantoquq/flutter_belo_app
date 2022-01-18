import 'package:belo_app/my_theme.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyTheme.kPrimaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        alignment: Alignment.center,
          child: Text(
        'This screen is still under development, come back later!',
        style: TextStyle(color: MyTheme.kPrimaryColor),
      )),
    );
  }
}
