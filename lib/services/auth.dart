import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatbox/model/user.dart';
class AuthMethods{
final FirebaseAuth _auth=FirebaseAuth.instance;
User_model? _userFromFirebaseUser(User? user){
return user !=null ? User_model(userId: user.uid):null;
}
Future signInWithEmailAndPassowrd(String email,String password) async {
try{
  UserCredential result=await _auth.signInWithEmailAndPassword
    (email: email, password: password);
  User? firebaseUser=result.user;
  return _userFromFirebaseUser(firebaseUser);
} catch(e){

}
}
Future signUpwithEmailAndPassword(String email,String password) async{
  try{
    UserCredential result=await _auth.createUserWithEmailAndPassword
      (email: email, password: password);
    User? firebaseUser=result.user;
    return _userFromFirebaseUser(firebaseUser);
  }catch(e){
    print(e.toString());
  }
}
Future resetPass(String email)async{
  try{
    return await _auth.sendPasswordResetEmail(email: email);
  }catch(e){
    print(e.toString());
  }
}
Future signOut() async{
  try{
      return await _auth.signOut();
  }catch(e){

  }
}

}