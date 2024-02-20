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
    apiKey: 'AIzaSyDtTuxQyeEo2_hiJi2-HbBuni2qCbn2Jgo',
    appId: '1:69814635759:web:19a8365776b6c065aedf1a',
    messagingSenderId: '69814635759',
    projectId: 'experimentdatabase-87de1',
    authDomain: 'experimentdatabase-87de1.firebaseapp.com',
    databaseURL: 'https://experimentdatabase-87de1-default-rtdb.firebaseio.com',
    storageBucket: 'experimentdatabase-87de1.appspot.com',
    measurementId: 'G-6LDNRQXFV1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4oT4KQgOSOuevGjJV12sNw60gZGUx7iA',
    appId: '1:69814635759:android:dfca09e14afc93a1aedf1a',
    messagingSenderId: '69814635759',
    projectId: 'experimentdatabase-87de1',
    databaseURL: 'https://experimentdatabase-87de1-default-rtdb.firebaseio.com',
    storageBucket: 'experimentdatabase-87de1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCo4KL4I2Mcw2mAL2_pZFGEB7fg1SoC388',
    appId: '1:69814635759:ios:4b3cbf091f14b08daedf1a',
    messagingSenderId: '69814635759',
    projectId: 'experimentdatabase-87de1',
    databaseURL: 'https://experimentdatabase-87de1-default-rtdb.firebaseio.com',
    storageBucket: 'experimentdatabase-87de1.appspot.com',
    androidClientId: '69814635759-gl1l3fcl45hn99a5dv48l2arnuhe7it1.apps.googleusercontent.com',
    iosClientId: '69814635759-b3gjerr7ippta8dcubac5c6flffi7rso.apps.googleusercontent.com',
    iosBundleId: 'com.example.sampleApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCo4KL4I2Mcw2mAL2_pZFGEB7fg1SoC388',
    appId: '1:69814635759:ios:4b3cbf091f14b08daedf1a',
    messagingSenderId: '69814635759',
    projectId: 'experimentdatabase-87de1',
    databaseURL: 'https://experimentdatabase-87de1-default-rtdb.firebaseio.com',
    storageBucket: 'experimentdatabase-87de1.appspot.com',
    androidClientId: '69814635759-gl1l3fcl45hn99a5dv48l2arnuhe7it1.apps.googleusercontent.com',
    iosClientId: '69814635759-b3gjerr7ippta8dcubac5c6flffi7rso.apps.googleusercontent.com',
    iosBundleId: 'com.example.sampleApplication',
  );
}
