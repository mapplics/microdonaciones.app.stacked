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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyeFx1p8OPn9mqELcV_ON5lAZ6mo36nEM',
    appId: '1:826758902094:android:45c3f220df25d621f0ee1f',
    messagingSenderId: '826758902094',
    projectId: 'microdonaciones-15b3f',
    storageBucket: 'microdonaciones-15b3f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoVu4ZFXdzzvfiJ_iogukopUCZujf0LUA',
    appId: '1:826758902094:ios:46618d1af979fd78f0ee1f',
    messagingSenderId: '826758902094',
    projectId: 'microdonaciones-15b3f',
    storageBucket: 'microdonaciones-15b3f.appspot.com',
    androidClientId: '826758902094-83quij1eeqifc1hh0iv05a9fhm3mrpg5.apps.googleusercontent.com',
    iosClientId: '826758902094-dn0ldmprl9s6p419eqqgh20g92cdedpk.apps.googleusercontent.com',
    iosBundleId: 'com.mapplics.microdonaciones',
  );
}
