import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  var messageController = new TextEditingController();

  Stream chatMessagesStream;
  firsFunc(){

  }

  Widget chatMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("ChatRoom")
          .doc(widget.chatRoomId)
          .collection("chats")
          .orderBy("time", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index].data()["message"],
                      isSendByMe: snapshot.data.docs[index].data()["sendBy"] == Constants.myName);
                },
              );
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationsMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sohbet"),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white10,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Yaz...",
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.white),
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
                            Icons.send,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            sendMessage();
                          }),
                    ),
                  ],
                ),
              ),
              //searchList()
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final message;
  final bool isSendByMe;
  MessageTile({this.message, this.isSendByMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0:24, right: isSendByMe ? 24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)]),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(23))),
        child: Text(
          message,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
