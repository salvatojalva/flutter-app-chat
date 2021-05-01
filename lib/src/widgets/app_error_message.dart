import 'package:flutter/material.dart';

class AppErrorMessage extends StatelessWidget {
  
  final String errorMessage;

  AppErrorMessage({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: TextStyle( 
          color: Colors.redAccent,
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          height: 1.0
        ),
      )
    ) ;
  }
}