import 'package:chatbox/helper/constants.dart';
import 'package:chatbox/helper/helperFunctions.dart';
import 'package:chatbox/services/database.dart';
import 'package:chatbox/views/conversationScreen.dart';
import 'package:chatbox/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
String? _myName;
class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();
   QuerySnapshot<Map<String, dynamic>>? searchSnapshot;

  initiateSearch(){
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((value) {
          setState(() {
            searchSnapshot=value;
          });

    });
  }
  //create Chatroom,send user to convo screen,pushreplacement
  createChatroomAndStartConversation(String userName){
    if(userName != Constants.myName){
      String chatRoomId =getChatRoomId(userName,Constants.myName);
      List<String> users = [userName,Constants.myName];
      Map<String,dynamic> chatRoomMap={
        "users":users,
        "chatroomId" : chatRoomId
      };
      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => conversationScreen()));
    }else{
      print("you cant talk to yourself");
    }

  }


  Widget searchList() {
    //var data = searchSnapshot?.docs!.data();
    return searchSnapshot !=null ? ListView.builder(
      shrinkWrap: true,
        itemCount: searchSnapshot?.docs.length,
        itemBuilder: (context, index) {
      return SearchTile(
      //  Map<String,dynamic> map = searchSnapshot.docs[index].data() as Map<String,dynamic>;
        userName: searchSnapshot?.docs[index].data()["name"],
        userEmail: searchSnapshot?.docs[index].data()["email"],

      );
    }):Container();
  }
  Widget SearchTile({String? userName, String? userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName!,style: simpleTextStyle(Colors.white, 18),),
              Text(userEmail!,style: simpleTextStyle(Colors.white, 16),)
            ],
          ),
          Spacer(),

          GestureDetector(
            onTap: (){
              createChatroomAndStartConversation(userName);

            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)

              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text("Message",style: simpleTextStyle(Colors.white, 16),),
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
  getUserInfo() async{
     _myName= await HelperFunctions.getUserNameSharedPreference();
     setState(() {

     });
     print(_myName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                        hintText: "search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();

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
