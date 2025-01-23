import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/firebase_options.dart';
import 'package:food/screen/Login/loginView.dart';
import 'package:food/screen/SignUp/signupview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food/screen/app/applocator.dart';
import 'package:food/screen/home/homeView.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with options for the current platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 // Setup the StackedLocator
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: SignupView(),
    );
  }
}

