import 'package:chat_app/src/services/authentication.dart';
import 'package:chat_app/src/services/message_service.dart';
import 'package:chat_app/src/widgets/app_chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  User loggedInUser;
  final _messageController = TextEditingController();


  InputDecoration _messageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20
    ),
    hintText: 'Escribe algo :)',
    
  );
  BoxDecoration _messageContinerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.lightBlueAccent, width: 2 )
    )
  );
  
  /*TextStyle _sendButtonStyle = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18
  );*/

  @override
  void initState(){
    super.initState();
    _getCurrentUser();
    _getMessages();
  }

  void _getCurrentUser() async {
    try{
      var user = await Authentication().getCurrentUser();
      if(user != null){
        loggedInUser = user;
        print('This is the logged user: ${loggedInUser.email}');
      }
    } catch(e){
      print(e);
    }
  }

  void _getMessages() async{
    
    await for(var snapshot in MessageService().getMessagesStream() ){
      snapshot.docs;
      
      for(var message in snapshot.docs){
        Map<String, dynamic> data = message.data();
        print(data);
        
      }
    }
  }

  

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("ChatRoom"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), 
            onPressed: (){
              Authentication().logoutUser();
              Navigator.pop(context);
            }
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea( 
        child: Column( 
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: MessageService().getMessagesStream(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }


                
                if(snapshot.hasData){
                  List<AppChatItem> messagesWidget = [];
                  List messagesTemp = [];
                  for( var item in snapshot.data.docs.toList() ){
                    
                    messagesTemp.add({
                      'value': item['value'],
                      'sender': item['sender'],
                      'updated': item['updated']
                    });
                  }

                  

                  messagesTemp.sort((a, b)=> a['updated'].toString().compareTo(b['updated'].toString()));

                  //print(messagesTemp);


                 messagesTemp.map(( document) {

                    
                    final messageValue = document['value'];
                    final messageSender = document['sender'];
                    
                    final isCurrentUserSender = (messageSender == loggedInUser.email) ? true : false;
                    
                    messagesWidget.add(
                      AppChatItem(message: messageValue, sender: messageSender, isCurrentUser: isCurrentUserSender)
                      
                    );

                  })
                  .toList();

                  return Flexible(
                    child: ListView(
                      children: messagesWidget
                    )
                  );

                }
                return Text("loading");
              },
            ),
            Container( 
              decoration: _messageContinerDecoration,
              child: Row(
                children: [
                  Expanded(
                    child: TextField( 
                      controller: _messageController,
                      decoration: _messageTextFieldDecoration,
                    )
                  ),
                  TextButton(
                    onPressed: (){
                      
                      MessageService().save(
                        "messages",
                        {
                          'value': _messageController.text,
                          'sender': loggedInUser.email
                        }
                      );
                      _messageController.clear();
                    }, 
                    child: Icon(Icons.send_rounded, color: Colors.lightBlueAccent,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}