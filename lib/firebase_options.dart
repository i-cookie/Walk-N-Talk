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
    apiKey: 'AIzaSyAq6rjg9J1trl_hLsB5uWfuZHbt3dlaIrA',
    appId: '1:517970202883:web:f27ed79e9a7cad9f6c1936',
    messagingSenderId: '517970202883',
    projectId: 'walkntalk-79fae',
    authDomain: 'walkntalk-79fae.firebaseapp.com',
    storageBucket: 'walkntalk-79fae.appspot.com',
    measurementId: 'G-376BLXQXHY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNTaCoxKF2gF2xHhuPmxrqugMS1AXQq1Y',
    appId: '1:517970202883:android:1c5fdd60e7e16e776c1936',
    messagingSenderId: '517970202883',
    projectId: 'walkntalk-79fae',
    storageBucket: 'walkntalk-79fae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkCUqQpyqydz3MqqWGeSV9TeWIiz8rdPs',
    appId: '1:517970202883:ios:e027c7f6cd671fba6c1936',
    messagingSenderId: '517970202883',
    projectId: 'walkntalk-79fae',
    storageBucket: 'walkntalk-79fae.appspot.com',
    iosBundleId: 'com.example.wnt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkCUqQpyqydz3MqqWGeSV9TeWIiz8rdPs',
    appId: '1:517970202883:ios:f3d96847367f64a56c1936',
    messagingSenderId: '517970202883',
    projectId: 'walkntalk-79fae',
    storageBucket: 'walkntalk-79fae.appspot.com',
    iosBundleId: 'com.example.wnt.RunnerTests',
  );
}
