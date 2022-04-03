import 'package:chatbox/helper/authenticate.dart';
import 'package:chatbox/services/auth.dart';
import 'package:chatbox/views/search.dart';
import 'package:chatbox/views/sigin.dart';
import 'package:chatbox/widgets/widget.dart';
import 'package:flutter/material.dart';
class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Dart-Logo-768x431.png",
          height: 40,
        ),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) =>Authenticate()
              ));

            },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.exit_to_app))
          )

        ],
        elevation: 0.0,
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen()));

        },
      ),
      
    );
  }
}
