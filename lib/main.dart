import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_revision/app.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCLz3VTyhGVboWTm2cdofL0QDxe3jaKmbc',
      appId: '1:405745395967:web:f613c6f38b8c0a8625c4ca',
      messagingSenderId: '405745395967',
      projectId: 'revisio-75880',
      storageBucket: 'revisio-75880.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}
