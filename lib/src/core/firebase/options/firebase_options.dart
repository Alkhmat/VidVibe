// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCC4gi6zvwUdpjXfnsW3NcfcIJtGTm6WAs',
    appId: '1:336765574961:web:0d1e95ea2360be86bdda10',
    messagingSenderId: '336765574961',
    projectId: 'vidvibe-bc849',
    authDomain: 'vidvibe-bc849.firebaseapp.com',
    storageBucket: 'vidvibe-bc849.appspot.com',
    measurementId: 'G-L0X0HCFWWE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2oU18NWeLrljYwHuo1iiVZfo6aBCPGT0',
    appId: '1:336765574961:android:ad9d13cac1e96414bdda10',
    messagingSenderId: '336765574961',
    projectId: 'vidvibe-bc849',
    storageBucket: 'vidvibe-bc849.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy3z_Y7eVcgTS9x1lVym9NuPRkQXW2Ukg',
    appId: '1:336765574961:ios:9c86928fc21e6981bdda10',
    messagingSenderId: '336765574961',
    projectId: 'vidvibe-bc849',
    storageBucket: 'vidvibe-bc849.appspot.com',
    iosClientId: '336765574961-18samaq4muah6rppqjsnu2vjomf7s5v4.apps.googleusercontent.com',
    iosBundleId: 'com.example.vidvibe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAy3z_Y7eVcgTS9x1lVym9NuPRkQXW2Ukg',
    appId: '1:336765574961:ios:9c86928fc21e6981bdda10',
    messagingSenderId: '336765574961',
    projectId: 'vidvibe-bc849',
    storageBucket: 'vidvibe-bc849.appspot.com',
    iosClientId: '336765574961-18samaq4muah6rppqjsnu2vjomf7s5v4.apps.googleusercontent.com',
    iosBundleId: 'com.example.vidvibe',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCC4gi6zvwUdpjXfnsW3NcfcIJtGTm6WAs',
    appId: '1:336765574961:web:242e402457490615bdda10',
    messagingSenderId: '336765574961',
    projectId: 'vidvibe-bc849',
    authDomain: 'vidvibe-bc849.firebaseapp.com',
    storageBucket: 'vidvibe-bc849.appspot.com',
    measurementId: 'G-9T7HS10ZR5',
  );
}