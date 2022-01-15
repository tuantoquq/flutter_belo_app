import 'package:belo_app/models/chat_model.dart';
import 'package:belo_app/screens/chat/detail_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final ChatCardModel chatCardModel;
  CustomCard(
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
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                'assets/icons/user_avt.svg',
                color: Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              chatCardModel.username,
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
