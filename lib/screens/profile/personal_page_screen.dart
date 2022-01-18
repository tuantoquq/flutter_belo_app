import 'package:belo_app/models/user.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/auth.dart';
import 'package:belo_app/provider/friends.dart';
import 'package:belo_app/screens/auth/auth_screen.dart';
import 'package:belo_app/screens/profile/setting_screen.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:belo_app/widgets/custom_button.dart';
import 'package:belo_app/widgets/profile_attribute_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalPageScreen extends StatefulWidget {
  static const routeName = '/personal-page';

  UserProfile friendCard;
  bool isMe;
  bool isFriend;
  bool isRequestFriend;
  bool isSendRequest;
  PersonalPageScreen(
      {Key? key,
      required this.friendCard,
      this.isMe = false,
      this.isFriend = false,
      this.isRequestFriend = false,
      this.isSendRequest = false})
      : super(key: key);

  @override
  State<PersonalPageScreen> createState() => _PersonalPageScreenState();
}

class _PersonalPageScreenState extends State<PersonalPageScreen> {
  Future<void> _logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
    Util.showErrorDialog('You are logged out!', context);
    Navigator.of(context).popAndPushNamed(AuthScreen.routeName);
  }

  Future<void> _sendRequest() async {
    await Provider.of<Friends>(context, listen: false)
        .sendRequestFriend(widget.friendCard.id);
    setState(() {
      widget.isSendRequest = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE9EBFF),
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: MyTheme.kPrimaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.isMe
                                      ? CustomButton('Logout', Colors.white,
                                          MyTheme.kPrimaryColor, _logout)
                                      : widget.isFriend
                                          ? CustomButton(
                                              'Go to Chat',
                                              Colors.white,
                                              MyTheme.kPrimaryColor,
                                              () {})
                                          : widget.isRequestFriend
                                              ? CustomButton(
                                                  'Accept request',
                                                  Colors.white,
                                                  Colors.blue,
                                                  () {})
                                              : widget.isSendRequest
                                                  ? CustomButton(
                                                      'Unsend',
                                                      Colors.white,
                                                      Colors.grey,
                                                      () {})
                                                  : CustomButton(
                                                      'Add friend',
                                                      Colors.white,
                                                      MyTheme.kPrimaryColor,
                                                      _sendRequest),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  widget.isMe
                                      ? CustomButton(
                                          'Go to Setting',
                                          Colors.white,
                                          MyTheme.kPrimaryColor, () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SettingScreen()));
                                        })
                                      : CustomButton('Block', Colors.white,
                                          MyTheme.kPrimaryColor, () {}),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.more_horiz))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [buildTop(), buildContent()],
        ));
  }

  Widget buildContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.friendCard.username,
            style: TextStyle(
                color: MyTheme.kPrimaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          const Text(
            'Become better',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xff6A757B)),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          buildAbout(),
        ],
      );

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.kPrimaryColor),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'You only live once, but if you do it right, once is enough.\n― Mae West',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )
          ],
        ),
      );

  Widget buildTop() => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            child: buildCoverImage(),
            margin: const EdgeInsets.only(bottom: 72),
          ),
          Positioned(
            child: buildProfileImage(),
            top: 148,
          ),
        ],
      );

  Widget buildCoverImage() => Container(
      color: MyTheme.kPrimaryColor,
      child: Image.asset('assets/images/cover_image.jpg',
          width: double.infinity, height: 220, fit: BoxFit.cover));

  Widget buildProfileImage() => CircleAvatar(
        radius: 72,
        backgroundColor: MyTheme.kPrimaryColor,
        backgroundImage: const AssetImage('assets/images/cat.jpg'),
      );
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = MyTheme.kPrimaryColor;
    Path path = Path()
      ..relativeLineTo(0, 100)
      ..quadraticBezierTo(size.width / 2, 160, size.width, 100)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
