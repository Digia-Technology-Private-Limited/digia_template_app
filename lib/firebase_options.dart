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
    apiKey: "AIzaSyACiPeAfpd751ajhOdzr86ikd0WqbiAqcQ",
    authDomain: "team-rudra-e62a3.firebaseapp.com",
    projectId: "team-rudra-e62a3",
    storageBucket: "team-rudra-e62a3.firebasestorage.app",
    messagingSenderId: "9270910034",
    appId: "1:9270910034:web:ac5e50898f24c3b53e138b",
    measurementId: "G-EP1HT914EE",
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAl9sPB5Mbt_BAxg1q70XVKGoAeSKE_qY',
    appId: '1:9270910034:android:2c731afe33b641343e138b',
    messagingSenderId: '9270910034',
    projectId: 'team-rudra-e62a3',
    storageBucket: 'team-rudra-e62a3.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhSlcBtaed2SbbiFJHVHhcgz7gBDewn-M',
    appId: '1:9270910034:ios:8fef72ed629981503e138b',
    messagingSenderId: '9270910034',
    projectId: 'team-rudra-e62a3',
    storageBucket: 'team-rudra-e62a3.firebasestorage.app',
  );
}
