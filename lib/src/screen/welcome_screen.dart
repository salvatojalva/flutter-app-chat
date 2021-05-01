import 'package:chat_app/src/widgets/app_button.dart';
import 'package:chat_app/src/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '';
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:  EdgeInsets.symmetric(horizontal: 25.0),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ 
            AppIcon(),
            SizedBox(height: 48),
            AppButton(
              textButton: 'Login', 
              colorButton: Colors.blueAccent, 
              onPressed: (){ Navigator.pushNamed( context, '/login' ); }
            ),
            AppButton(
              textButton: 'Registrar', 
              colorButton: Colors.lightBlueAccent, 
              onPressed: (){ Navigator.pushNamed( context, '/register' ); }
            ),
          ],
        ),
      ),
    );
  }
}