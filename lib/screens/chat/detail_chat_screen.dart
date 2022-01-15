import 'dart:io';

import 'package:belo_app/models/chat_model.dart';
import 'package:belo_app/screens/chat/conversation_info_screen.dart';

import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class DetailChatScreen extends StatefulWidget {
  DetailChatScreen({Key? key, required this.chatCardModel}) : super(key: key);
  final ChatCardModel chatCardModel;

  @override
  _DetailChatScreenState createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  TextEditingController _messageFieldController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 70,
          titleSpacing: 1,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.arrow_back),
                const SizedBox(
                  width: 1,
                ),
                CircleAvatar(
                  radius: 20,
                  child: SvgPicture.asset(
                    'assets/icons/user_avt.svg',
                    color: Colors.white,
                    height: 36,
                    width: 36,
                  ),
                  backgroundColor: Colors.grey,
                )
              ],
            ),
          ),
          title: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatCardModel.username,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text('Active now', style: TextStyle(fontSize: 13))
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConversationInfoScreen()));
                },
                icon: const Icon(
                  Icons.toc_outlined,
                  size: 30,
                ))
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                        margin: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          controller: _messageFieldController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type a message',
                              contentPadding: const EdgeInsets.only(left: 15),
                              suffixIcon:IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                Icons.camera_alt_outlined)
                              )
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 5),
                    child: CircleAvatar(
                      radius: 21,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white,),
                        onPressed: (){},
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
