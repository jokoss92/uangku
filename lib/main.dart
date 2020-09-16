import 'package:flutter/material.dart';
import 'package:uangku_/screens/home.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uangku Application',
      theme: ThemeData(
        primaryColor: Colors.red
      ),
      home: Home()
    );
  }
}