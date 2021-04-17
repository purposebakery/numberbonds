import 'package:flutter/material.dart';
import 'numberbonds/numberbondspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numberbonds',
      theme: ThemeData(
        primarySwatch: Colors.grey,
          //fontFamily: 'Minecraftia'
      ),
      home: NumberBondsPage(),
    );
  }
}

