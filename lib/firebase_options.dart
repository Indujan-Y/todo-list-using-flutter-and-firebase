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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAWgbWFlH22lI3vyXORjWDk-r0eio3UFcs',
    appId: '1:307288817779:web:a54e71552443ae37362a06',
    messagingSenderId: '307288817779',
    projectId: 'todo-list-app-e462d',
    authDomain: 'todo-list-app-e462d.firebaseapp.com',
    storageBucket: 'todo-list-app-e462d.appspot.com',
    measurementId: 'G-PDR90PT26B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-OsIvbolx7WdCD6QsULKC2CZAujXWvcM',
    appId: '1:307288817779:android:47ac54c26e754bbb362a06',
    messagingSenderId: '307288817779',
    projectId: 'todo-list-app-e462d',
    storageBucket: 'todo-list-app-e462d.appspot.com',
  );
}