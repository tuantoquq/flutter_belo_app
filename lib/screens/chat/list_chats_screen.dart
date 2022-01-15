import 'package:belo_app/models/chat_model.dart';
import 'package:belo_app/widgets/custom_cart.dart';
import 'package:flutter/material.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({Key? key}) : super(key: key);

  @override
  _ListChatScreenState createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  List<ChatCardModel> listChats = [
    ChatCardModel(
        username: "Tuan Nguyen",
        lastMessage: "Hi tomorrow",
        lastSendTime: "10:30"),
    ChatCardModel(
        username: "Bich",
        lastMessage: "Goodnight for my honey!",
        lastSendTime: "12:35"),
    ChatCardModel(
        username: "Manh Dung",
        lastMessage: "Hello my brother!",
        lastSendTime: "21:23")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('List Chats')),
        body: ListView.builder(
          itemCount: listChats.length,
          itemBuilder: (context, index) => CustomCard(chatCardModel: listChats[index]),
        ));
  }
}
