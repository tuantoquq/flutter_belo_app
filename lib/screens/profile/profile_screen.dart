import 'package:belo_app/models/models.dart';
import 'package:belo_app/provider/api.dart';
import 'package:belo_app/provider/auth.dart';
import 'package:belo_app/screens/auth/auth_screen.dart';
import 'package:belo_app/screens/profile/personal_page_screen.dart';
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
    _userInfo = UserDetailProfile(
        username: response['data']['username'],
        phonenumber: response['data']['phonenumber'],
        avtURL: '');
  }

  Future<void> _logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
    Navigator.of(context).popAndPushNamed(AuthScreen.routeName);
  }

  Future<void> _myAccountInfo() async {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => PersonalPageScreen(userProfile: _userInfo,)
    ));
  }

  Future<void> _settingInfo() async {}
  Future<void> _helpCenterInfo() async {}

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
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
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
                    CustomButton(Icons.help, 'Help Center', _helpCenterInfo),
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
