import 'package:belo_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  final FriendCard friendCard;
  const ContactCard({Key? key, required this.friendCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      title: Text(friendCard.username,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),),
    );
  }
}
