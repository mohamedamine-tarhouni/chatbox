import 'package:chatbox/services/auth.dart';
import 'package:chatbox/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/helperFunctions.dart';
import '../widgets/widget.dart';
import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  bool isLoading=false;
  QuerySnapshot<Map<String, dynamic>>? snapshotUserInfo;
  signIn(){
    final form = formKey.currentState;
    if(form != null && form.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      setState(() {
        isLoading=true;
      });
      databaseMethods.getUserByUseremail(emailTextEditingController.text).then((value){
        snapshotUserInfo=value;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo?.docs[0].data()["name"]);
        print("${snapshotUserInfo?.docs[0].data()["name"]}");

      });
      authMethods.signInWithEmailAndPassowrd(
          emailTextEditingController.text,
          passwordTextEditingController.text).then((value){
            if(value !=null){

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) =>ChatRoom()
              ));
            }
      });


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: Column(children: [
                      TextFormField(
                          validator: (val){
                            return val!=null&&RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                            null : "Enter a correct email";
                          },
                          controller: emailTextEditingController,
                          style: simpleTextStyle(Colors.white, 16),
                          decoration: textFieldInputDecoration("email")),
                      TextFormField(
                          obscureText: true,
                          validator: (val){
                            return val!=null&&(val.length>6) ? null:"password must contain 6+ characters";
                          },
                          controller: passwordTextEditingController,
                          style: simpleTextStyle(Colors.white, 16),
                          decoration: textFieldInputDecoration("password")),
                    ]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "ForgotPassword?",
                        style: simpleTextStyle(Colors.white, 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: (){
                      signIn();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Sign In",
                        style: simpleTextStyle(Colors.white, 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign In With Google",
                      style: simpleTextStyle(Colors.black87, 17),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: simpleTextStyle(Colors.white, 17),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(),
                            child: Text(
                              "Register Now",
                              style: simpleTextStyle(Colors.blueAccent, 17),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
