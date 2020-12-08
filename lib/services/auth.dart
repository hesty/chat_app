import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/model/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserR _userFromFirabaseUser(User user) {
    return user != null ? UserR(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirabaseUser(firebaseUser);
    } catch (e) {
      print("Giris catchi"+e);
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirabaseUser(firebaseUser);

      //AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)as FirebaseUser;


    } catch (e) {
      print("Kayit Catchii"+e.toString());
    }
  }
  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
    print("Cikis ==== "+e.toString());
    }
  }

}
