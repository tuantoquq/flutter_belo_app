import 'package:belo_app/models/chat.dart';
import 'package:belo_app/models/user.dart';
import 'package:belo_app/screens/chat/detail_chat_screen.dart';
import 'package:belo_app/screens/profile/personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserSearchCard extends StatefulWidget {
  final UserProfile friendCard;
  const UserSearchCard({Key? key, required this.friendCard}) : super(key: key);

  @override
  State<UserSearchCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<UserSearchCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PersonalPageScreen(friendCard: widget.friendCard)));
        },
        leading: const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/cat.jpg'),
        ),
        title: Text(
          widget.friendCard.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
