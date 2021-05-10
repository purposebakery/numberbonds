import 'package:flutter/material.dart';
import 'package:numberbonds/home/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numberbonds',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: HomePage(),
    );
  }
}

