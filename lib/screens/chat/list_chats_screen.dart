import 'package:belo_app/models/chat.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/chats.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:belo_app/widgets/conversation_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({Key? key}) : super(key: key);

  @override
  _ListChatScreenState createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  late dynamic _fetch;
  Future<void> _fetchListChats() {
    return Provider.of<Chats>(context, listen: false).getListChats();
  }

  @override
  void initState() {
    _fetch = _fetchListChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetch,
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: _fetchListChats,
                    child: Scaffold(
                        body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Recent Chats',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Consumer<Chats>(builder: (ctx, chatData, _) {
                            return ListView.builder(
                              itemCount: chatData.listChats.length,
                              itemBuilder: (context, index) => ConversationCard(
                                  chatCardModel: chatData.listChats[index]),
                            );
                          }),
                        ),
                      ],
                    )),
                  ));
  }
}
