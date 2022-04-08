import 'package:chatbox/views/sigin.dart';
import 'package:chatbox/views/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}
//cette page permet de gérer le changement entre les pages sign in et signup
//le bouton register now dans Sign In
//le bouton Sign in now dans Sign Up
class _AuthenticateState extends State<Authenticate> {

  bool showSignIn=true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView);
    }else{
      return SignUp(toggleView);

    }
  }
}
