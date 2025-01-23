import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupModel extends BaseViewModel {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
 
 final FirebaseFirestore firestore =FirebaseFirestore.instance;
  storeData(BuildContext context)async{
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.text,
    password: password.text,
  );
  await firestore.collection('users').doc(credential.user!.uid).set({
   'email':email.text.trim(),
   'password':password.text.trim(),
   'name':name.text.trim(),
    });
      return "User registered successfully!";

} 
on FirebaseAuthException catch (e) {
  
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
  
} catch (e) {
  print(e);
  
}

  }
}

