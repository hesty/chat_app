import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/views/chat_room_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsloggedIn;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
    setState(() {
      userIsloggedIn= value;
    });
    });
  }

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
      home:userIsloggedIn !=null ? /**/ userIsloggedIn ? ChatRoom() : Authenticate()/**/
          : Authenticate() ,
    );
  }
}


