import 'package:flutter/material.dart';

@override
//configuration d'une AppBar commune
AppBar appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/Dart-Logo-768x431.png",
      height: 40,
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}
//configuration d'un textfield commun
InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );
}
//Style d'un texte
TextStyle simpleTextStyle(Color color,double FS){
  return TextStyle(
    color: color,
    fontSize: FS
  );

}

