import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
>>>>>>> 9c8bd5ad71905ddc4b20277b7fdef50dcd10c43f


class Auth {
//Creating new instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /*
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // you can also store the user in Database
    

  }
  */

  
// sign with email and password

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
<<<<<<< HEAD
      debugPrint(e.toString());
=======
      print(e.toString());
>>>>>>> 9c8bd5ad71905ddc4b20277b7fdef50dcd10c43f
    }
  }

// signout

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (error) {
<<<<<<< HEAD
      debugPrint(error.toString());
=======
      print(error.toString());
>>>>>>> 9c8bd5ad71905ddc4b20277b7fdef50dcd10c43f
      return null;
    }
  }
}
