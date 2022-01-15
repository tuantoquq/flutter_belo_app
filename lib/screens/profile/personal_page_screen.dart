import 'package:belo_app/models/models.dart';
import 'package:flutter/material.dart';

class PersonalPageScreen extends StatelessWidget {
  static const routeName = '/personal-page';
  final UserDetailProfile userProfile;
  const PersonalPageScreen({Key? key, required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.purple,
        title: Text(
          userProfile.username,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
