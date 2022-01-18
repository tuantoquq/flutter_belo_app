import 'package:belo_app/models/user.dart';
import 'package:belo_app/screens/profile/personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class RequestedCard extends StatelessWidget {
  UserProfile friendCard;
  RequestedCard({Key? key, required this.friendCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PersonalPageScreen(
                    friendCard: friendCard,
                    isSendRequest: true,
                  )));
        },
        leading: CircleAvatar(
          radius: 23,
          child: SvgPicture.asset(
            'assets/icons/user_avt.svg',
            color: Colors.white,
            height: 30,
            width: 30,
          ),
          backgroundColor: Colors.blueGrey[200],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              friendCard.username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            CustomFriendButton(
                'Cancel', () {}, const Color(0xffFFEDEB), Colors.black)
          ],
        ),
      ),
    );
  }
}

class CustomFriendButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const CustomFriendButton(
    this.text,
    this.action,
    this.backgroundColor,
    this.textColor, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            primary: backgroundColor,
          ),
          onPressed: action,
          child: Container(
              width: 60,
              height: 30,
              padding: const EdgeInsets.all(5),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: textColor),
              ))),
    );
  }
}
