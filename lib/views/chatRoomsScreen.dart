import 'package:chatbox/helper/authenticate.dart';
import 'package:chatbox/helper/constants.dart';
import 'package:chatbox/helper/helperFunctions.dart';
import 'package:chatbox/services/auth.dart';
import 'package:chatbox/services/database.dart';
import 'package:chatbox/views/search.dart';
import 'package:chatbox/views/sigin.dart';
import 'package:chatbox/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'conversationScreen.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  late Stream<QuerySnapshot<Map<String, dynamic>>>? chatRoomsStream;
  Widget ChatRoomList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return ChatRoomTile(
                  snapshot.data?.docs[index].data()['chatroomId'],
                  snapshot.data?.docs[index].data()['chatroomId']);
            })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(padding: EdgeInsets.all(7)),
            Image.asset("assets/images/dart.png", height: 30),
            const SizedBox(width: 15,),
            PopupMenuButton<int>(
              child: Row(
                children: [
                  Text(Constants.myName, style: TextStyle(fontSize: 20),),
                  const SizedBox(width: 8),
                  FaIcon(FontAwesomeIcons.chevronDown, size: 14),
                ],
              ),

              color: Colors.white,
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      const SizedBox(width: 8,),
                      Text('dÃ©connexion'),
                    ],
                  ),
                ),
              ],
            ),
            /* child: Text('User',style: TextStyle(fontSize: 20)),

            dropdown
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
            }
             */
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                authMethods.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.person_add, size: 28,)))
        ],
        elevation: 0.0,
        centerTitle: false,
      ),
      body: ChatRoomList(),
    );
  }

  //dropdown deconnexion
  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Authenticate()));
        break;
    }
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  ChatRoomTile(this.userName, this.chatRoom);
  // const ChatRoomTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => conversationScreen(chatRoom)));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${userName.replaceAll("_", "").replaceAll(Constants.myName, "").substring(0, 1)}",
                style: simpleTextStyle(Colors.white, 22),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(Constants.myName, ""),
              style: simpleTextStyle(Colors.white, 18),
            )
          ],
        ),
      ),
    );
  }
}