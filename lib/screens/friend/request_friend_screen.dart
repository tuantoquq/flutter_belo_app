import 'package:belo_app/models/user.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/friends.dart';
import 'package:belo_app/widgets/received_card.dart';
import 'package:belo_app/widgets/requested_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestFriendScreen extends StatefulWidget {
  const RequestFriendScreen({Key? key}) : super(key: key);

  @override
  _RequestFriendScreenState createState() => _RequestFriendScreenState();
}

class _RequestFriendScreenState extends State<RequestFriendScreen>
    with TickerProviderStateMixin {
  dynamic _listReceivedFriend;
  List<UserProfile>? _listRequestedFriend;

  Future<void> _fetchReceivedFriend() async{
    dynamic provider = Provider.of<Friends>(context, listen: false);
    await provider.getListReceivedFriend();
    _listReceivedFriend = provider.listReceivedFriend;
  }

  final listReceived = [
    UserProfile(username: 'Bích Nobi', avtURL: '', id: ''),
    UserProfile(username: 'Tuấn Nguyễn', avtURL: '', id: ''),
    UserProfile(username: 'Anh Tuấn', avtURL: '', id: ''),
    UserProfile(username: 'Đào Tiên', avtURL: '', id: ''),
    UserProfile(username: 'Sơn Nguyễn', avtURL: '', id: ''),
    UserProfile(username: 'Bích Nobi', avtURL: '', id: ''),
    UserProfile(username: 'Tuấn Nguyễn', avtURL: '', id: ''),
    UserProfile(username: 'Anh Tuấn', avtURL: '', id: ''),
    UserProfile(username: 'Đào Tiên', avtURL: '', id: ''),
    UserProfile(username: 'Sơn Nguyễn', avtURL: '', id: ''),
  ];
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Request Friend',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
      ),
      backgroundColor: MyTheme.kPrimaryColor,
      body: RefreshIndicator(
        onRefresh: _fetchReceivedFriend,
        child: Column(
          children: [
            RequestFriendTabBar(tabController: tabController),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: TabBarView(controller: tabController, children: [
                  FutureBuilder(
                      future: _fetchReceivedFriend(),
                      builder: (ctx, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => ReceivedCard(
                                        friendCard: _listReceivedFriend![index]),
                                    itemCount: _listReceivedFriend!.length,
                                  ),
                                )),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          RequestedCard(friendCard: listReceived[index]),
                      itemCount: listReceived.length,
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RequestFriendTabBar extends StatelessWidget {
  const RequestFriendTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: TabBar(
        controller: tabController,
        indicator: ShapeDecoration(
            color: MyTheme.kAccentColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        tabs: [
          Tab(
            icon: Text(
              'Received',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Tab(
            icon: Text(
              'Requested',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
