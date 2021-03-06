import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchSearchScreenState createState() => _SearchSearchScreenState();
}

class _SearchSearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEdittingController.text)
        .then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  createChatroomAndStartConversation(String userName) {

    String chatRoomId = getChatRoomId(userName, Constants.myName);
    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId
    };

    if (userName != Constants.myName) {
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    }else{
      AlertDialog alert = AlertDialog(
        title: Text("Sakin OL"),
        content: Text("Kendine Mesaj Gonderemezsin."),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }


  }

  Widget searchTile({String userName, String userMail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(userMail,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Text(
                "Mesaj Gonder",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  var searchTextEdittingController = new TextEditingController();

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                userName: searchSnapshot.docs[index].data()["name"],
                userMail: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arama"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white10,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEdittingController,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Kulanici Ara...",
                        hintStyle: TextStyle(fontSize: 20, color: Colors.white),
                        border: InputBorder.none),
                  )),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          initiateSearch();
                        }),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
