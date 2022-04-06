import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../services/database.dart';
import '../widgets/widget.dart';
class conversationScreen extends StatefulWidget {
  late final String chatRoomId;
  @override
  State<conversationScreen> createState() => _conversationScreenState();
}

class _conversationScreenState extends State<conversationScreen> {
  //const conversationScreen({Key? key}) : super(key: key);
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController messageController = new TextEditingController();

  /*Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data.documents.lenth,
            itemBuilder: (context, index){
              return
            });
      },
    );
  }*/

  sendMessage() {

    if(messageController.text.isNotEmpty){
      Map<String, String> messageMap = {
        "message" : messageController.text,
        "sendBy" : Constants.myName,
      };
      //databaseMethods.getConversationMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                         // controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none),
                        )),
                    GestureDetector(
                      onTap: () {
                       // sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF),
                              ]),
                              borderRadius: BorderRadius.circular(8)),
                          child: Image.asset(
                              "assets/images/icons8-chercher-30.png")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
