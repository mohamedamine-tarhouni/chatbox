import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance.collection("Users_chat")
        .where("name", isEqualTo: username)
        .get();
  }
  getUserByUseremail(String userEmail) async {
    return await FirebaseFirestore.instance.collection("Users_chat")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("Users_chat")
        .add(userMap);
  }

  createChatRoom(String charRoomId, chatRoomMap) {
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(charRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
}