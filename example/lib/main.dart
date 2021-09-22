import 'package:esptouch_example/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:esptouch_example/login.dart';
//import 'package:flutter_application_1/Homescreen.dart';
//import 'package:flutter_application_1/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // عشان البانر يتشال
      home: Login(),
    );
  }
}
