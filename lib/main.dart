import 'package:flutter/material.dart';
import 'package:numberbonds/numberbonds/numberbondsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numberbonds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
          //fontFamily: 'Minecraftia'
      ),
      home: NumberBondsPage(),
    );
  }
}

