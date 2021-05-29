import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/pages/home/HomePage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numberbonds',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}
