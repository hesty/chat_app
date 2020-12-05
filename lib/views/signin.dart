import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giris Yap"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: textFieldDecoration("E-Posta"),
                  ),
                  TextField(
                    decoration: textFieldDecoration("Sifre"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text("Sifremi Unuttum",style: TextStyle(color: Colors.white,fontSize: 15),),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ])),
                    child: Text(
                      "Giris Yap",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Text(
                      "Google ile Giris Yap",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hesabin yok mu? ",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6) ,
                          child: Text("Kayit OL",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 40,)
                ],
              )),
        ),
      ),
    );
  }
}
