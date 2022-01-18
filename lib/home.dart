import 'package:belo_app/my_theme.dart';
import 'package:belo_app/screens/chat/list_chats_screen.dart';
import 'package:belo_app/screens/dashboard/news_feed_screen.dart';
import 'package:belo_app/screens/friend/friend_screen.dart';
import 'package:belo_app/screens/profile/profile_screen.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> tabs = [
    const ListChatScreen(),
    const FriendScreen(),
    const NewsFeedScreen(),
    const ProfileScreen()
  ];

  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentScreen = const ListChatScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        title: const TextField(
          autofocus: false,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search friends ...',
              hintStyle: TextStyle(color: Colors.white)),
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: pageStorageBucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const ListChatScreen();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat,
                        color: currentTab == 0 ? Colors.blue : Colors.grey),
                    Text(
                      'Chat',
                      style: TextStyle(
                          color: currentTab == 0 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const FriendScreen();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.contact_page,
                        color: currentTab == 1 ? Colors.blue : Colors.grey),
                    Text(
                      'Friend',
                      style: TextStyle(
                          color: currentTab == 1 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const NewsFeedScreen();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home,
                        color: currentTab == 2 ? Colors.blue : Colors.grey),
                    Text(
                      'News Feed',
                      style: TextStyle(
                          color: currentTab == 2 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const ProfileScreen();
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle,
                        color: currentTab == 3 ? Colors.blue : Colors.grey),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: currentTab == 3 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
