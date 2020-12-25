import 'package:blood_donation_app/src/RegisterPage.dart';
import 'package:blood_donation_app/src/Welcome.dart';
import 'package:flutter/material.dart';
import 'src/FirstPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}
