import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/views/chat_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenn extends StatefulWidget {
  @override
  _SplashScreennState createState() => _SplashScreennState();
}

class _SplashScreennState extends State<SplashScreenn> {
  bool userIsloggedIn;

  @override
  void initState() {
    getLoggedInState();
    print(userIsloggedIn);
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsloggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: userIsloggedIn != null ? /**/ userIsloggedIn ? Authenticate() : ChatRoom() /**/ : Authenticate(),
      title: new Text("Hesty Chat App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white)),
      image: Image.asset("assets/images/splashicon.png"),
      photoSize: 50,
      gradientBackground: LinearGradient(
        colors: [
          const Color(0xff007EF4),
          const Color(0xff2A75BC)
        ]
      ),
      loaderColor: Colors.white,

    );
  }
}
