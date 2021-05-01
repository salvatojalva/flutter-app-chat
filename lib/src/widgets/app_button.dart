import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String textButton; 
  final MaterialAccentColor colorButton; 
  final VoidCallback onPressed;
  
  AppButton({this.textButton, this.colorButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
     return Padding( 
      padding: EdgeInsets.symmetric(vertical: 10.0 ),
      child: Material( 
        color: colorButton,
        borderRadius: BorderRadius.circular(30),
        elevation: 9,
        child: SizedBox(
          height: 40,
          child: TextButton( 
            onPressed: onPressed,
            child: Text(
              textButton, 
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      )
    );
  }
}