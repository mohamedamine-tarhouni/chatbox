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
  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){print(e.toString());});
  }

  getConversationMessages(String chatRoomId) async{
    return await FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats").orderBy("time")
        .snapshots();
  }
  getChatRooms(String userName) async{
    return await FirebaseFirestore.instance.collection("ChatRoom")
        .where("users",arrayContains: userName)
        .snapshots();

  }
}