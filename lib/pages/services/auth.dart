import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Registered User
  RegisteredUser? _userFromFirebaseUser(User? user){
    if (user != null) {
      return RegisteredUser(uid: user.uid);
    } else {
      return null;
    }
  }

  //Stream
  Stream<RegisteredUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e) {
      return null;
    }
  }
  //sign in
  Future signInWithCredentials(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e);
      return null;
    }
  }

  //register
  Future registerUser(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user?.uid).updateUserData("user",  "address", email, password, ' ');

      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e);
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
          return null;
    }
  }
}