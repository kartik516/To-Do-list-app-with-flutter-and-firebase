
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
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
    apiKey: 'AIzaSyB7FjVMUf19i-ouHbQztqd-5MxVMso9vp0',
    appId: '1:82242947212:android:0ad5c7596c7e5a5b70d3a9',
    messagingSenderId: '82242947212',
    projectId: 'todo-firebase-yt-4345b',
    storageBucket: 'todo-firebase-yt-4345b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxgxMtjH_2PfmcFYHzXY0lCllyNfwQWII',
    appId: '1:82242947212:ios:e239f35e4bb28ca070d3a9',
    messagingSenderId: '82242947212',
    projectId: 'todo-firebase-yt-4345b',
    storageBucket: 'todo-firebase-yt-4345b.firebasestorage.app',
    iosBundleId: 'com.example.todoFirebaseYt' ,
  
  );

}

// firebase ex