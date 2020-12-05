import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png",
      width: 100,
    ),
    backgroundColor: Color.fromRGBO(17, 47, 65, 100),
  );
}

InputDecoration textFieldDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,

      hintStyle: TextStyle(color: Colors.white, fontSize: 20),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}
