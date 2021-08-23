import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/pages/home/HomePage.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';

class App extends StatelessWidget {
  static const SCREENSHOT_MODE = false;

  @override
  Widget build(BuildContext context) {
    initialize(context);
    return MaterialApp(
      title: 'Numberbonds',
      theme: ThemeData(primarySwatch: SGColors.action,
          backgroundColor: SGColors.background),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  void initialize(BuildContext context) {
    GoalStore.resetGoalProgressIfNewDay(GoalType.EASY);
    GoalStore.resetGoalProgressIfNewDay(GoalType.NORMAL);
    GoalStore.resetGoalProgressIfNewDay(GoalType.DIFFICULT);
    if (SCREENSHOT_MODE) {
      GoalStore.setGoalProgress(GoalType.EASY, 25);
      GoalStore.setGoalProgress(GoalType.NORMAL, 10);
      GoalStore.setGoalProgress(GoalType.DIFFICULT, 9);

      GoalStore.setGoal(GoalType.EASY, 25);
      GoalStore.setGoal(GoalType.NORMAL, 25);
      GoalStore.setGoal(GoalType.DIFFICULT, 25);
    }
  }
}
