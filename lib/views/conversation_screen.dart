import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
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

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context,  snapshot) {
        return ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            return MessageTile(message: "deneme");
          },
        );
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, String> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName
      };
      databaseMethods.addConversationsMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationsMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

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
  MessageTile({this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
