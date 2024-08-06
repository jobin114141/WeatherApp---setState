import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> SignUpWithEmailAndPasword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {}

      return credential.user;
    } catch (e) {
      print("some Error occured");
    }
    return null;
  }

  Future<User?> SignInWithEmailAndPasword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      print("Sign IN");
      return credential.user;
    } catch (e) {
      print("some Error occured");
    }
    return null;
  }

  Future<void> SaveuserDetails(username, email, user) async {
    print(user?.uid);
    await FirebaseFirestore.instance
        .collection("UserDetails")
        .doc(user?.uid)
        .set({"userName": username, "email": email});
  }
}
