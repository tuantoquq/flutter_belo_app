import 'dart:io';

import 'package:belo_app/models/chat.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/api.dart';
import 'package:belo_app/provider/chats.dart';
import 'package:belo_app/screens/chat/conversation_info_screen.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:belo_app/widgets/message_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class DetailChatScreen extends StatefulWidget {
  DetailChatScreen({Key? key, required this.chatCardModel}) : super(key: key);
  final ChatCardModel chatCardModel;

  @override
  _DetailChatScreenState createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  TextEditingController _messageFieldController = TextEditingController();

  dynamic _fetch;
  late IO.Socket socket;

  Future<void> _fetchMessages() {
    return Provider.of<Chats>(context, listen: false)
        .getListMessagesOfChat(widget.chatCardModel.chatId);
  }

  void connect() {
    socket = IO.io(
        'http://192.168.1.6:8000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    // socket.emit("signin", widget.chatCardModel.chatId);
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
  }

  @override
  void initState() {
    _fetch = _fetchMessages();
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.kPrimaryColor,
        toolbarHeight: 100,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/cat.jpg'),
              radius: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatCardModel.partnerName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text('Active now',
                    style: TextStyle(
                      fontSize: 13,
                    ))
              ],
            )
          ],
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
        elevation: 0,
      ),
      backgroundColor: MyTheme.kPrimaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: FutureBuilder(
                    future: _fetch,
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Consumer<Chats>(builder: (context, chatsData, _) {
                                return ListView.builder(
                                  itemCount: chatsData.listMessages.length,
                                  itemBuilder: (context, index) => MessageCard(
                                      chatDetailModel:
                                          chatsData.listMessages[index]),
                                );
                              }),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: Colors.white,
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 60,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageFieldController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message ...',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[500])),
                            ),
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                      radius: 25,
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: sendMessage,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    MessagesChat messagesChat = MessagesChat(
        receivedName: widget.chatCardModel.partnerName,
        receivedId: widget.chatCardModel.partnerId,
        chatId: widget.chatCardModel.chatId,
        content: _messageFieldController.text);
    await Api.sendMessage(await Util.getToken(), messagesChat);
    setState(() {
      _messageFieldController.clear();
    });
  }
}
