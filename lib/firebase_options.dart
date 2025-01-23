// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAqCFeFHjZ2KUHxfv7wW9L4zD5gSutcg6k',
    appId: '1:671663706740:web:ad3d994039ed3431153721',
    messagingSenderId: '671663706740',
    projectId: 'recipesfood-b61ec',
    authDomain: 'recipesfood-b61ec.firebaseapp.com',
    storageBucket: 'recipesfood-b61ec.firebasestorage.app',
    measurementId: 'G-ZZNC2YHQDB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAuvvaRgvPXz8MlW8Su-_AAS2wiGjgsDM',
    appId: '1:671663706740:android:9ed49231cbda3b23153721',
    messagingSenderId: '671663706740',
    projectId: 'recipesfood-b61ec',
    storageBucket: 'recipesfood-b61ec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJ-K-Ss9Q1zXBxMgEmsZ0eUf2hMSPBKmU',
    appId: '1:671663706740:ios:37e080d923a4deb7153721',
    messagingSenderId: '671663706740',
    projectId: 'recipesfood-b61ec',
    storageBucket: 'recipesfood-b61ec.firebasestorage.app',
    iosBundleId: 'com.example.food',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJ-K-Ss9Q1zXBxMgEmsZ0eUf2hMSPBKmU',
    appId: '1:671663706740:ios:37e080d923a4deb7153721',
    messagingSenderId: '671663706740',
    projectId: 'recipesfood-b61ec',
    storageBucket: 'recipesfood-b61ec.firebasestorage.app',
    iosBundleId: 'com.example.food',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAqCFeFHjZ2KUHxfv7wW9L4zD5gSutcg6k',
    appId: '1:671663706740:web:5fffbcde630a0347153721',
    messagingSenderId: '671663706740',
    projectId: 'recipesfood-b61ec',
    authDomain: 'recipesfood-b61ec.firebaseapp.com',
    storageBucket: 'recipesfood-b61ec.firebasestorage.app',
    measurementId: 'G-TWFFFGXEPD',
  );
}
