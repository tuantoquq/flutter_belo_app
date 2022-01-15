import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String content;
  final Color textColor;
  final Color bgColor;
  final VoidCallback action;
  final double btnWidth;
  final double btnHeight;
  final double fontSize;

  const CustomButton(
    this.content,
    this.textColor,
    this.bgColor,
    this.action, {
    this.btnWidth = 250,
    this.btnHeight = 55,
    this.fontSize = 17,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      child: SizedBox(
        child: Center(
          child: Text(
            content,
            style: TextStyle(fontSize: fontSize, color: textColor),
          ),
        ),
        width: btnWidth,
        height: btnHeight,
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
        primary: bgColor,
      ),
    );
  }
}
