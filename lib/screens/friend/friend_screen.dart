import 'package:belo_app/models/user.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/friends.dart';
import 'package:belo_app/screens/friend/request_friend_screen.dart';
import 'package:belo_app/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  dynamic _listFriend;

  Future<void> _fetchListFriend() async {
    dynamic provider = Provider.of<Friends>(context, listen: false);
    await provider.getListFriend();
    _listFriend = provider.listFriend;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchListFriend(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RequestFriendScreen()));
                    },
                    leading: Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: const Icon(
                        Icons.group_add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    title: const Text(
                      'Friend Requests',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'List Friends',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          ContactCard(friendCard: _listFriend![index]),
                      itemCount: _listFriend!.length,
                    ),
                  )
                ],
              )));
  }
}

class DataSearch extends SearchDelegate<String> {
  final listFriend = [];

  final suggestSearch = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Result');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suggestSearch
        : listFriend
            .where((element) => element.username.toLowerCase().contains(query))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) =>
          ContactCard(friendCard: suggestionList[index]),
      itemCount: suggestionList.length,
    );
  }
}
