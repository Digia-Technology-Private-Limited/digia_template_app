import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB0kAOhoNCl4aet1m9nsjidFvxs6URMRgE",
    authDomain: "fir-digia.firebaseapp.com",
    projectId: "fir-digia",
    storageBucket: "fir-digia.firebasestorage.app",
    messagingSenderId: "879019274041",
    appId: "1:879019274041:web:8912f02e1c59569cfb02e8",
    measurementId: "G-LB5S938854",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcjvY8iXS-2cM1NbQfbebIug0cn0K2doo',
    appId: '1:879019274041:android:ac77532b48734611fb02e8',
    messagingSenderId: '879019274041',
    projectId: 'fir-digia',
    storageBucket: 'fir-digia.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUuf9sOm8IcfR1D5PkG30fnAXwXWG2kvE',
    appId: '1:879019274041:ios:2fd118bfb96c9aa3fb02e8',
    messagingSenderId: '879019274041',
    projectId: 'fir-digia',
    storageBucket: 'fir-digia.firebasestorage.app',
  );
}
