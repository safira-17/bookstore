import 'package:bookstore_app/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDIiop_T2LKaiiQKcVaAKLwvAzxsT7t_5k",
      appId: "1:602658111615:android:209456de4b2e6c049d3f4a",
      messagingSenderId: "HI",
      projectId: "safira-67e15",
      storageBucket: "safira-67e15.firebasestorage.app",
    ),
  );
  print("Firebase initialized successfully!");

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookstore App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: WelcomePage(), 
    );
  }
}
