import 'package:belo_app/my_theme.dart';
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
        body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        alignment: Alignment.center,
          child: Text(
        'This screen is still under development, come back later!',
        style: TextStyle(color: MyTheme.kPrimaryColor),
      )),
    );
  }
}
