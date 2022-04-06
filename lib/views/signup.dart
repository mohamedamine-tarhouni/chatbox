import 'package:chatbox/helper/helperFunctions.dart';
import 'package:chatbox/services/auth.dart';
import 'package:chatbox/services/database.dart';
import 'package:chatbox/views/chatRoomsScreen.dart';
import 'package:flutter/material.dart';
import '../widgets/widget.dart';

class SignUp extends StatefulWidget {
  //const SignUp({Key? key}) : super(key: key);
  final Function toggle;
  SignUp(this.toggle);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();
  final formKey=GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp() async{
    final form = formKey.currentState;
    if(form != null && form.validate()){
      Map<String,String> userInfoMap={
        "name" : userNameTextEditingController.text,
        "email" : emailTextEditingController.text
      };
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
        

      setState(() {
        isLoading=true;
      });
      await authMethods.signUpwithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((value) {
        // ignore: avoid_print
       // print("${value.uid}");

        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>ChatRoom()
        ));
    
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key:formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val){
                            return val!=null&&(val.length<4) ? "Enter a correct username":null;
                          },
                            controller: userNameTextEditingController,
                            style: simpleTextStyle(Colors.white, 16),
                            decoration: textFieldInputDecoration("username")),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: (){
                      signMeUp();
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
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text(
                        "Sign Up",
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
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text(
                      "Sign Up With Google",
                      style: simpleTextStyle(Colors.black87, 17),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",style: simpleTextStyle(Colors.white, 17),),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text("Sign In now",style: simpleTextStyle(Colors.blueAccent, 17),)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
