import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/screen/home/homeView.dart';
import 'package:stacked/stacked.dart';

class Loginmodel extends ChangeNotifier{
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  loginUSer(BuildContext context)async{
try {
  final credential= await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email.text,
     password: password.text);
  if(credential.user!=null){
    print("okie");
   Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context){
      return HomeView();
    }));
    notifyListeners();
  }
}
on FirebaseAuthException catch(e){
  if(e.code=='user-not-found'){
    print("User not same");
  }
  else if(e.code=='wrong-password'){
    print("Wrong Password");
  }
}
  }
}

