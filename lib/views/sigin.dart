import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextField(
                  style: simpleTextStyle(Colors.white, 16),
                  decoration: textFieldInputDecoration("email")),
              TextField(
                  style: simpleTextStyle(Colors.white, 16),
                  decoration: textFieldInputDecoration("password")),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "ForgotPassword?",
                    style: simpleTextStyle(Colors.white, 16),
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
                    gradient: LinearGradient(colors: [
                  const Color(0xff007EF4),
                  const Color(0xff2A75BC)
                ]),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text(
                  "Sign In",
                  style: simpleTextStyle(Colors.white, 17),
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
                    borderRadius: BorderRadius.circular(30)
                ),
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
                  Text("Don't have an account? ",style: simpleTextStyle(Colors.white, 17),),
                  Text("Register Now",style: simpleTextStyle(Colors.blueAccent, 17),),
                ],
              )
            ],
          )
      ),
    );
  }
}
