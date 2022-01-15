import 'package:flutter/material.dart';

class ConversationInfoScreen extends StatefulWidget {
  const ConversationInfoScreen({Key? key}) : super(key: key);

  @override
  _ConversationInfoScreenState createState() => _ConversationInfoScreenState();
}

class _ConversationInfoScreenState extends State<ConversationInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Container(
                child: const Text('Option', style: TextStyle(fontSize: 20),),
                margin: const EdgeInsets.all(5),
              ),
            )
        ),
        body: Container(),
    );
  }
}
