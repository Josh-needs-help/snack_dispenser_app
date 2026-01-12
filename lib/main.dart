import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Models/History.dart';
import 'package:snack_dispenser_app/Pages/PageGallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyA43v0gLpvm-aLcVxScO9-XkCXA0kGL-MM',
  appId: '1:323099588493:web:ed907f54ecbc3d68acefc4',
  messagingSenderId: '323099588493',
  projectId: 'snackdispenser-acf0e',
  authDomain: 'snackdispenser-acf0e.firebaseapp.com',
  databaseURL: 'https://snackdispenser-acf0e-default-rtdb.firebaseio.com',
  storageBucket: 'snackdispenser-acf0e.appspot.com',
  measurementId: 'G-JB98295Q1W',
);
  if(kIsWeb)
  {
    await Firebase.initializeApp(
      options: web,
    );
  }
  else{
    await Firebase.initializeApp();
    FirebaseDatabase.instance.setPersistenceEnabled(true);
  }
  History.instance.start();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PageGallery()
    );
  }
}
