import 'dart:ui';

import 'package:chat_app/src/screen/chat_scree.dart';
import 'package:chat_app/src/screen/register_screen.dart';
import 'package:chat_app/src/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp( 
      home: WelcomeScreen(),
      theme: ThemeData( 
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black45)
        )
      ),
      initialRoute: WelcomeScreen.routeName,
      routes: < String, WidgetBuilder >{
        LoginScreen.routeName: (BuildContext context) => LoginScreen(),
        WelcomeScreen.routeName: (BuildContext context) => WelcomeScreen(),
        RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
        ChatScreen.routeName: (BuildContext context) => ChatScreen()
      }
    )
  );
}