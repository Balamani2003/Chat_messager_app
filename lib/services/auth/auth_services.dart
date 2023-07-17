

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthServices extends ChangeNotifier{
  final FirebaseAuth _auth=FirebaseAuth.instance;

final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  // sign in database
  Future<UserCredential> signinwithemailandpassword(String email,String password) async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection("users").doc(result. user!.uid).set({
        'uid':result.user!.uid,
        'email':email,
      },SetOptions(merge: true));
      return result;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  // sign up new user
  Future<UserCredential> signupwithemailandpassword(String email,String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // after user signup creating a document in firebase
     _firestore.collection("users").doc(result. user!.uid).set({
       'uid':result.user!.uid,
       'email':email,
     });

      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign out function
Future<void> signout() async{
    return await _auth.signOut();
}

}