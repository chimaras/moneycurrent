import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:moneycurrent/screens/auth_screen.dart'; // Pantalla de autenticación

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return web; // Coloca aquí las configuraciones correctas para cada plataforma si son diferentes
      default:
        throw UnsupportedError('Plataforma no soportada.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBIBzeqNWg7JWSKnKwOHrfoNtu0scLJDLM',
    appId: '1:764854630705:web:978f969303d21feacc1810',
    messagingSenderId: '764854630705',
    projectId: 'moneycurrent-app',
    authDomain: 'moneycurrent-app.firebaseapp.com',
    databaseURL: 'https://moneycurrent-app-default-rtdb.firebaseio.com',
    storageBucket: 'moneycurrent-app.appspot.com',
    measurementId: 'G-P4WVT2SWYP',
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyCurrent',
      theme: ThemeData(
        primarySwatch: Colors.green, // Color acorde a tu branding
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(), // Dirige a la pantalla de autenticación
    );
  }
}
