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
    apiKey: 'AIzaSyCW4aXBiVNQwriS93Dt-OQa0sUrJUPctYg',
    appId: '1:961788590304:web:cec57e4943e3c51a0e7885',
    messagingSenderId: '961788590304',
    projectId: 'ai-trainer-db',
    authDomain: 'ai-trainer-db.firebaseapp.com',
    storageBucket: 'ai-trainer-db.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_A5gi3Dfh8ncLWAhxfyRK36mR7coI3GY',
    appId: '1:961788590304:android:40db75ae72e169920e7885',
    messagingSenderId: '961788590304',
    projectId: 'ai-trainer-db',
    storageBucket: 'ai-trainer-db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGwcBvfmH0OZFlKu7SO5riZ3KcAvXn-9w',
    appId: '1:961788590304:ios:ccac08650aebdb120e7885',
    messagingSenderId: '961788590304',
    projectId: 'ai-trainer-db',
    storageBucket: 'ai-trainer-db.appspot.com',
    iosClientId: '961788590304-vs4vedkg0ss1bbtje1mkicp8qdr9mp3q.apps.googleusercontent.com',
    iosBundleId: 'com.example.aiTrainer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGwcBvfmH0OZFlKu7SO5riZ3KcAvXn-9w',
    appId: '1:961788590304:ios:ccac08650aebdb120e7885',
    messagingSenderId: '961788590304',
    projectId: 'ai-trainer-db',
    storageBucket: 'ai-trainer-db.appspot.com',
    iosClientId: '961788590304-vs4vedkg0ss1bbtje1mkicp8qdr9mp3q.apps.googleusercontent.com',
    iosBundleId: 'com.example.aiTrainer',
  );
}
