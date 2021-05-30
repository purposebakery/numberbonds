import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/pages/home/HomePage.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initialize();
    return MaterialApp(
      title: 'Numberbonds',
      theme: ThemeData(primarySwatch: SGColors.action),
      home: HomePage(),
    );
  }

  void initialize() {
    GoalStore.resetGoalProgressIfNewDay();
  }
}
