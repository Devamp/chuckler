// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart';
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
    apiKey: 'AIzaSyA7uTIvQj8XN91oojHEaFepc8pcEiOeH-8',
    appId: '1:25599306163:web:b1e55a0ce61ec7c90843c6',
    messagingSenderId: '25599306163',
    projectId: 'chuckler-622ff',
    authDomain: 'chuckler-622ff.firebaseapp.com',
    storageBucket: 'chuckler-622ff.appspot.com',
    measurementId: 'G-YR00YD69RG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuAM9zQ3I2l5e9HeYNQfQnuncij13DshY',
    appId: '1:25599306163:android:fc581e1e6b15a9140843c6',
    messagingSenderId: '25599306163',
    projectId: 'chuckler-622ff',
    storageBucket: 'chuckler-622ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4eUGNKw-29L4VBs74x-eOiZ-Fc5ICdEE',
    appId: '1:25599306163:ios:81726f4c966ad1990843c6',
    messagingSenderId: '25599306163',
    projectId: 'chuckler-622ff',
    storageBucket: 'chuckler-622ff.appspot.com',
    iosBundleId: 'com.example.chuckler',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4eUGNKw-29L4VBs74x-eOiZ-Fc5ICdEE',
    appId: '1:25599306163:ios:47368a09c9e594f10843c6',
    messagingSenderId: '25599306163',
    projectId: 'chuckler-622ff',
    storageBucket: 'chuckler-622ff.appspot.com',
    iosBundleId: 'com.example.chuckler.RunnerTests',
  );

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('Firebase initialization succeeded');
    } catch (e) {
      print('Firebase initialization failed: $e');
    }
    await Firebase.initializeApp();
  }
}
