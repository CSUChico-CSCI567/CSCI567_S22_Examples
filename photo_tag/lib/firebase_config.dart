import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          apiKey: "AIzaSyDvdu7_0_h8OxBsV8n-lgHPHtZcrll2qLU",
          authDomain: "csci567s22.firebaseapp.com",
          projectId: "csci567s22",
          storageBucket: "csci567s22.appspot.com",
          messagingSenderId: "452029871180",
          appId: "1:452029871180:web:dd8cb1357858a799f930e9"
          //   );
          // } else if (Platform.isIOS || Platform.isMacOS) {
          //   // iOS and MacOS
          //   return const FirebaseOptions(
          //     appId: '1:448618578101:ios:0b650370bb29e29cac3efc',
          //     apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
          //     projectId: 'react-native-firebase-testing',
          //     messagingSenderId: '448618578101',
          //     iosBundleId: 'io.flutter.plugins.firebasecoreexample',
          );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:452029871180:android:00432358fa9ea8e6f930e9',
        apiKey: 'AIzaSyAfrxaXL4gwl_5DFE3EEI3L_8vXIYHC62o',
        projectId: 'csci567s22',
        messagingSenderId: '452029871180',
      );
    }
  }
}
