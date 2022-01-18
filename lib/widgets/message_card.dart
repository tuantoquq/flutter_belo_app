import 'package:belo_app/models/chat.dart';
import 'package:belo_app/my_theme.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  ChatDetailModel chatDetailModel;
  MessageCard({Key? key, required this.chatDetailModel}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool isMe = true;
  @override
  void initState() {
    isMe =
        widget.chatDetailModel.senderId == widget.chatDetailModel.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe)
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/cat.jpg'),
                  radius: 15,
                ),
                const SizedBox(width: 8,),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(10),
                child: Text(widget.chatDetailModel.content,
                    style: MyTheme.bodyTextMessage),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                decoration: BoxDecoration(
                    color: isMe ? MyTheme.kAccentColor : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomRight: Radius.circular(isMe ? 0 : 12),
                        bottomLeft: Radius.circular(isMe ? 12 : 0))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isMe)
                  const SizedBox(
                    width: 40,
                  ),
                Icon(
                  Icons.done_all,
                  size: 20,
                  color: MyTheme.bodyTextTime.color,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.chatDetailModel.sendTime,
                  style: MyTheme.bodyTextTime,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
