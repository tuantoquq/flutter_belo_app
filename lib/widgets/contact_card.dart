import 'package:belo_app/models/chat.dart';
import 'package:belo_app/models/user.dart';
import 'package:belo_app/screens/chat/detail_chat_screen.dart';
import 'package:belo_app/screens/profile/personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatefulWidget {
  final UserProfile friendCard;
  const ContactCard({Key? key, required this.friendCard}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailChatScreen(
                      chatCardModel: ChatCardModel(
                          chatId: '',
                          lastMessage: '',
                          lastSendTime: '',
                          partnerName: widget.friendCard.username,
                          partnerId: '',
                          username: ''))));
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
