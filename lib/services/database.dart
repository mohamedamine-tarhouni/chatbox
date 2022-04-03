import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUsername(String username) async {
   /* return await FirebaseFirestore.instance.collection("user")
        .where("name", isEqualTo: username)
        .get();*/
  }
  getUserByUseremail(String userEmail) async {
   /* return await FirebaseFirestore.instance.collection("user")
        .where("email", isEqualTo: userEmail)
        .get();*/
  }

  uploadUserInfo(String name,String email) {
    /*Firestore.instance.collection("user")
        .add(userMap).catchError((e){
      print(e.toString());
    });*/
    FirebaseFirestore.instance.collection("Utilisateurs").add(data)
  }

  createChatRoom(String charRoomId, chatRoomMap) {
   /* Firestore.instance.collection("ChatRoom")
        .document(charRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });*/
  }
}