import 'dart:async';

import 'package:belo_app/home.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/auth.dart';
import 'package:belo_app/provider/chats.dart';
import 'package:belo_app/provider/friends.dart';
import 'package:belo_app/provider/user.dart';
import 'package:belo_app/screens/auth/auth_screen.dart';
import 'package:belo_app/screens/auth/welcome_screen.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Chats()),
        ChangeNotifierProvider(create: (ctx) => Friends()),
        ChangeNotifierProvider(create: (ctx) => User()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Belo Social',
          theme: ThemeData(
              primaryColor: MyTheme.kPrimaryColor,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
          home: auth.isAuth
              ? const Home()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator())
                          : const WelcomeScreen()),
          routes: {
            WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
            Home.routeName: (ctx) => const Home(),
            AuthScreen.routeName: (ctx) => const AuthScreen()
          },
        ),
      ),
    );
  }
}
