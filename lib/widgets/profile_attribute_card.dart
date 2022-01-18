import 'package:belo_app/my_theme.dart';
import 'package:flutter/material.dart';

class ProfileAttributeCard extends StatelessWidget {
  final String attribute;
  final Icon icon;
  ProfileAttributeCard({Key? key, required this.attribute, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: MyTheme.kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          attribute,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
