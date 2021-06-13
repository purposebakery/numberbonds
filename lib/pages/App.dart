import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/pages/home/HomePage.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';
import 'package:numberbonds/styleguide/constants/SGSizes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initialize(context);
    return MaterialApp(
      title: 'Numberbonds',
      theme: ThemeData(primarySwatch: SGColors.action),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  void initialize(BuildContext context) {
    GoalStore.resetGoalProgressIfNewDay();
  }
}
