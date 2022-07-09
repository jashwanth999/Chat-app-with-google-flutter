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
    apiKey: 'AIzaSyCnRdiCwWR3VidYnXav-eAcZgko_LC3Gms',
    appId: '1:897554427385:web:8aa299c1def9d698c22128',
    messagingSenderId: '897554427385',
    projectId: 'chat-app-8ac40',
    authDomain: 'chat-app-8ac40.firebaseapp.com',
    databaseURL: 'https://chat-app-8ac40.firebaseio.com',
    storageBucket: 'chat-app-8ac40.appspot.com',
    measurementId: 'G-X4YTWSRSHL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVzEqZQzwi29nWgbA8JXO52RywrLgnmRs',
    appId: '1:897554427385:android:99a9d730fa4fba55c22128',
    messagingSenderId: '897554427385',
    projectId: 'chat-app-8ac40',
    databaseURL: 'https://chat-app-8ac40.firebaseio.com',
    storageBucket: 'chat-app-8ac40.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDPev7d42oryXtdImf-RymrvBfWyB8iwY',
    appId: '1:897554427385:ios:e101ee880d35c68cc22128',
    messagingSenderId: '897554427385',
    projectId: 'chat-app-8ac40',
    databaseURL: 'https://chat-app-8ac40.firebaseio.com',
    storageBucket: 'chat-app-8ac40.appspot.com',
    iosClientId: '897554427385-og6gg9qcgocdaaiaifv53dfrin57aq4p.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDPev7d42oryXtdImf-RymrvBfWyB8iwY',
    appId: '1:897554427385:ios:e101ee880d35c68cc22128',
    messagingSenderId: '897554427385',
    projectId: 'chat-app-8ac40',
    databaseURL: 'https://chat-app-8ac40.firebaseio.com',
    storageBucket: 'chat-app-8ac40.appspot.com',
    iosClientId: '897554427385-og6gg9qcgocdaaiaifv53dfrin57aq4p.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
