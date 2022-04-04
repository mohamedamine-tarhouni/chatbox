import 'package:chatbox/services/database.dart';
import 'package:chatbox/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();
  QuerySnapshot? searchSnapshot;
  initiateSearch(){
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((value) {
          setState(() {
            searchSnapshot=value;
          });

    });
  }
  Widget searchList() {
    //var data = searchSnapshot?.docs!.data();
    return searchSnapshot !=null ? ListView.builder(
      shrinkWrap: true,
        itemCount: searchSnapshot?.docs.length,
        itemBuilder: (context, index) {
      return SearchTile(
        /*userName: searchSnapshot?.docs[index]["name"],
        userEmail: searchSnapshot?.docs[index]["email"],*/
       /* userName: searchSnapshot?.docs[index].data()["name"],
        userEmail: "midouch",*/

      );
    }):Container();
  }
@override
  void initState() {
    initiateSearch();
    super.initState();
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

class SearchTile extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  SearchTile({this.userName,this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(userName!,style: simpleTextStyle(Colors.white, 16),),
              Text(userEmail!,style: simpleTextStyle(Colors.white, 16),)
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30)

            ),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Text("Message"),
          )
        ],
      ),
    );
  }
}
