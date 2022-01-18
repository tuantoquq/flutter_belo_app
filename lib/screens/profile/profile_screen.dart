import 'package:belo_app/models/user.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/api.dart';
import 'package:belo_app/provider/auth.dart';
import 'package:belo_app/screens/auth/auth_screen.dart';
import 'package:belo_app/screens/profile/personal_page_screen.dart';
import 'package:belo_app/screens/profile/setting_screen.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  dynamic _userInfo;

  Future<void> _getUserInfo() async {
    final response = await Api.getUserInfo(await Util.getToken());
    _userInfo = UserProfile(
        username: response['data']['username'],
        id: response['data']['_id'],
        avtURL: '');
  }

  Future<void> _logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
    Util.showErrorDialog('You are logged out!', context);
    Navigator.of(context).popAndPushNamed(AuthScreen.routeName);
  }

  Future<void> _myAccountInfo() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonalPageScreen(
                  friendCard: _userInfo,
                  isMe: true,
                )));
  }

  void _settingInfo() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingScreen()));
  }

  void _aboutUsHandle() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 300,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'About us',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.kPrimaryColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const Text(
                    'Application developed by tuantoquq & annd \n 1-2022.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserInfo(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Profile',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/cat.jpg'),
                      radius: 50,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _userInfo.username,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                        Icons.account_box_sharp, 'My Account', _myAccountInfo),
                    const SizedBox(height: 15),
                    CustomButton(Icons.settings, 'Setting', _settingInfo),
                    const SizedBox(height: 15),
                    CustomButton(Icons.help, 'About us', _aboutUsHandle),
                    const SizedBox(height: 15),
                    CustomButton(Icons.logout, 'Log Out', _logout),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback action;
  final String text;
  const CustomButton(
    this.icon,
    this.text,
    this.action, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: Colors.grey[300],
        ),
        onPressed: action,
        child: Container(
          width: 290,
          height: 65,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
            ],
          ),
        ));
  }
}
