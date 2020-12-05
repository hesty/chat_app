import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/views/chatRoomScreen.dart';
import 'package:chat_app/views/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white38,
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff145C9E),
      ),
      home: ChatRoom(),
    );
  }
}

