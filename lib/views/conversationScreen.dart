import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../services/database.dart';
import '../widgets/widget.dart';
class conversationScreen extends StatefulWidget {
  late final String chatRoomId;

  conversationScreen(this.chatRoomId);
  @override
  State<conversationScreen> createState() => _conversationScreenState();
}

class _conversationScreenState extends State<conversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  //le message à envoyer
  TextEditingController messageController = new TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>>? chatMessagesStream;

  //affichage des messages(comme la recherche des
  // utilisateurs mais sans recharger la page)
  Widget ChatMessageList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              return MessageTile(snapshot.data?.docs[index].data()['message'],
                  snapshot.data?.docs[index].data()['sendBy']==Constants.myName);
            }) :Container();
      },
    );
  }
//envoie du message
  sendMessage() {

    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
        "message" : messageController.text,
        "sendBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text="";
    }
  }
@override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream=value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  //la page des messages
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none),
                        )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF),
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(
                              "assets/images/send.png")),
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
//la fonction d'affichage des messages selon l'utilisateur connecté
class MessageTile extends StatelessWidget {
  //const MessageTile({Key? key}) : super(key: key);
  final String message;
  final bool isSentByMe;
  MessageTile(this.message,this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSentByMe ?  0:24,right: isSentByMe ?  24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment:isSentByMe ? Alignment.centerRight : Alignment.centerLeft ,
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSentByMe ? [
              const Color(0xff007EF4),
              const Color(0xff007EF4)
            ] : [
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF)
            ]
          ),
          borderRadius: isSentByMe ?
              BorderRadius.only(
                topLeft:Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
              ):
          BorderRadius.only(
              topLeft:Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
          )


        ),
        child: Text(message,style: simpleTextStyle(Colors.white, 20),),
      ),
    );
  }
}

