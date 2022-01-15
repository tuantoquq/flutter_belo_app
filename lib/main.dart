import 'package:belo_app/home.dart';
import 'package:belo_app/provider/auth.dart';
import 'package:belo_app/screens/auth/auth_screen.dart';
import 'package:belo_app/screens/auth/welcome_screen.dart';
import 'package:belo_app/screens/profile/personal_page_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
      ],
      child: MaterialApp(
        title: 'Belo Social',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.green),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: const WelcomeScreen(),
        routes: {
          WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
          Home.routeName: (ctx) => const Home(),
          AuthScreen.routeName: (ctx) => const AuthScreen()
        },
      ),
    );
  }
}

