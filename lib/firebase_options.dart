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
    apiKey: 'AIzaSyDYXsOxytP7_1hsw2LFGXBfuUajZzIxYbc',
    appId: '1:217517053415:web:06cb6f241c55efcbe99942',
    messagingSenderId: '217517053415',
    projectId: 'tiktok-clone-cc91d',
    authDomain: 'tiktok-clone-cc91d.firebaseapp.com',
    storageBucket: 'tiktok-clone-cc91d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWAae2rq-qgEh7OE-BpuRVKoGOUCH7_RQ',
    appId: '1:217517053415:android:c207af9f1b775d04e99942',
    messagingSenderId: '217517053415',
    projectId: 'tiktok-clone-cc91d',
    storageBucket: 'tiktok-clone-cc91d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4GnYnuxExpzOi5ekXuM0HxXqj_lvejwM',
    appId: '1:217517053415:ios:d6b7e642799d380fe99942',
    messagingSenderId: '217517053415',
    projectId: 'tiktok-clone-cc91d',
    storageBucket: 'tiktok-clone-cc91d.appspot.com',
    iosClientId: '217517053415-4lrhvepfb9ngko5tlnprgg8h0r2mev37.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4GnYnuxExpzOi5ekXuM0HxXqj_lvejwM',
    appId: '1:217517053415:ios:7b7fc9b31ee4ebc3e99942',
    messagingSenderId: '217517053415',
    projectId: 'tiktok-clone-cc91d',
    storageBucket: 'tiktok-clone-cc91d.appspot.com',
    iosClientId: '217517053415-qd5b20f48bceh00k37tqj2sm1thtbv7n.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokClone.RunnerTests',
  );
}