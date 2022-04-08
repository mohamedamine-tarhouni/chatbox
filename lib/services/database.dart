import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //recuperation des données de l'utilisateur par username
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("Users_chat")
        .where("name", isEqualTo: username)
        .get();
  }

  //recuperation des données de l'utilisateur par mail
  getUserByUseremail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("Users_chat")
        .where("email", isEqualTo: userEmail)
        .get();
  }

//sauvegarde des données de l'utilisateur
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("Users_chat").add(userMap);
  }

//ajout d'un chatroom et la mettre dans la base de données
  createChatRoom(String charRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(charRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  //ajout d'un message dans la base de données
  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

//récuperation des messages par l'id de chatroom
  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  //recuperation des chatroom
  getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
