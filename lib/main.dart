import 'package:chatbox/helper/authenticate.dart';
import 'package:chatbox/helper/helperFunctions.dart';
import 'package:chatbox/views/chatRoomsScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    getLoggedInState();
    // TODO: implement initState
    super.initState();
  }
  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn=value!;
      });


    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff145C9E),
          scaffoldBackgroundColor: Color(0xff1F1F1F),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:    userIsLoggedIn ? ChatRoom() : Authenticate());
  }
}


