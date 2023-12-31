// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCdNBh1c0-3bDw9mtSQc4HclkBIDPcZVNI',
    appId: '1:546388646785:web:3376815b57549c43126680',
    messagingSenderId: '546388646785',
    projectId: 'flutter-c35b4',
    authDomain: 'flutter-c35b4.firebaseapp.com',
    storageBucket: 'flutter-c35b4.appspot.com',
    measurementId: 'G-YXNT939541',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqlFKmAF0Z5gvrAMORClUSUbeEYGMKpy8',
    appId: '1:546388646785:android:bad361a7f4b9c98f126680',
    messagingSenderId: '546388646785',
    projectId: 'flutter-c35b4',
    storageBucket: 'flutter-c35b4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOB1JDQRIbdr6sK4KPW_ll7WT7An1S9I8',
    appId: '1:546388646785:ios:f19435c721db3fd9126680',
    messagingSenderId: '546388646785',
    projectId: 'flutter-c35b4',
    storageBucket: 'flutter-c35b4.appspot.com',
    iosBundleId: 'com.example.fluuuteer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOB1JDQRIbdr6sK4KPW_ll7WT7An1S9I8',
    appId: '1:546388646785:ios:3f870b92fdda0776126680',
    messagingSenderId: '546388646785',
    projectId: 'flutter-c35b4',
    storageBucket: 'flutter-c35b4.appspot.com',
    iosBundleId: 'com.example.fluuuteer.RunnerTests',
  );
}
