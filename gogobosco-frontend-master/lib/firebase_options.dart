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
    apiKey: 'AIzaSyDummyKeyHereForGoGoBoscoAuth',
    appId: '1:109876543210:web:abcdef1234567890',
    messagingSenderId: '109876543210',
    projectId: 'gogobosco',
    authDomain: 'gogobosco.firebaseapp.com',
    storageBucket: 'gogobosco.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyHereForGoGoBoscoAuth',
    appId: '1:109876543210:android:abcdef1234567890',
    messagingSenderId: '109876543210',
    projectId: 'gogobosco',
    storageBucket: 'gogobosco.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyHereForGoGoBoscoAuth',
    appId: '1:109876543210:ios:abcdef1234567890',
    messagingSenderId: '109876543210',
    projectId: 'gogobosco',
    storageBucket: 'gogobosco.appspot.com',
    iosBundleId: 'com.example.gogobosco',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyHereForGoGoBoscoAuth',
    appId: '1:109876543210:ios:abcdef1234567890',
    messagingSenderId: '109876543210',
    projectId: 'gogobosco',
    storageBucket: 'gogobosco.appspot.com',
    iosBundleId: 'com.example.gogobosco',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyHereForGoGoBoscoAuth',
    appId: '1:109876543210:web:abcdef1234567890',
    messagingSenderId: '109876543210',
    projectId: 'gogobosco',
    authDomain: 'gogobosco.firebaseapp.com',
    storageBucket: 'gogobosco.appspot.com',
  );
}
