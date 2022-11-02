import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:murtaza_final_project/Screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // primarySwatch: Colors.green,
          ),
      home: SplashTwo(),
      debugShowCheckedModeBanner: false,
    );
  }
}
