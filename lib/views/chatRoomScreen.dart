import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/search.dart';

import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
 AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Odasi"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.perm_identity,color: Colors.white,),
        ),
        actions: [
          IconButton(
            onPressed: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authenticate()));
            },
              icon: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ))
        ],
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen()));
        },
      ),
    );
  }
}
