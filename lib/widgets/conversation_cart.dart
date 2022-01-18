import 'package:belo_app/models/chat.dart';
import 'package:belo_app/screens/chat/detail_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConversationCard extends StatelessWidget {
  final ChatCardModel chatCardModel;
  ConversationCard(
      {Key? key,
      required this.chatCardModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailChatScreen(chatCardModel: chatCardModel,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/cat.jpg'),
            ),
            title: Text(
              chatCardModel.partnerName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chatCardModel.lastMessage,
              style: const TextStyle(fontSize: 13),
            ),
            trailing: Text(chatCardModel.lastSendTime),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
