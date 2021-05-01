import 'package:flutter/material.dart';

class AppChatItem extends StatelessWidget {

  final String sender;
  final String message;
  final bool isCurrentUser;

  AppChatItem({this.message, this.sender, this.isCurrentUser: false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 11,
              color: Colors.black54
            ),
          ),
          Material(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
              child: Text(
                message,
                style: TextStyle( 
                  fontSize: 13,
                  color: isCurrentUser ? Colors.grey:  Colors.white
                ),
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
            ),
            color: isCurrentUser ? Colors.white : Colors.lightBlueAccent,
            
          )
          
        ],
      ),
    );
  }
}