import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('images/logo.png'),
        Expanded(
          child: Text(
            'Flutter Chat', 
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700

            ),
          ),
        ),
      ],
    );
  }
}