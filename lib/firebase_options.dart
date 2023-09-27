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
    apiKey: 'AIzaSyCMIH_WSXai_hhfNFHFla4cZlsSri4-XtU',
    appId: '1:1016755285499:web:60c2c18a74c7f803b3af5e',
    messagingSenderId: '1016755285499',
    projectId: 'flutter-cooking-app-e5a3e',
    authDomain: 'flutter-cooking-app-e5a3e.firebaseapp.com',
    storageBucket: 'flutter-cooking-app-e5a3e.appspot.com',
    measurementId: 'G-Z9CDT7EF3G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEr6lAvd65jeCHwuZ8dUzqYkuBkv3lKbo',
    appId: '1:1016755285499:android:e7a6411a1918a9feb3af5e',
    messagingSenderId: '1016755285499',
    projectId: 'flutter-cooking-app-e5a3e',
    storageBucket: 'flutter-cooking-app-e5a3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCu5cbdfmnUt1d3zHlwD6OAbQ-2Q6LCI4U',
    appId: '1:1016755285499:ios:f6686a59ddc65120b3af5e',
    messagingSenderId: '1016755285499',
    projectId: 'flutter-cooking-app-e5a3e',
    storageBucket: 'flutter-cooking-app-e5a3e.appspot.com',
    iosBundleId: 'app.web.caul',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCu5cbdfmnUt1d3zHlwD6OAbQ-2Q6LCI4U',
    appId: '1:1016755285499:ios:352e06e2ceac33ffb3af5e',
    messagingSenderId: '1016755285499',
    projectId: 'flutter-cooking-app-e5a3e',
    storageBucket: 'flutter-cooking-app-e5a3e.appspot.com',
    iosBundleId: 'app.web.caul.RunnerTests',
  );
}
