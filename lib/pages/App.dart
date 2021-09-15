import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/model/TaskType.dart';
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
    GoalStore.resetGoalProgressIfNewDay(TaskType.NUMBERBONDS_OF_10);
    GoalStore.resetGoalProgressIfNewDay(TaskType.ADDITION_SINGLE_DIGIT);
    GoalStore.resetGoalProgressIfNewDay(TaskType.SUBTRACTION_SINGLE_DIGIT);
    GoalStore.resetGoalProgressIfNewDay(TaskType.TIMESTABLE_TO_10);

    if (SCREENSHOT_MODE) {
      GoalStore.setGoalProgress(TaskType.NUMBERBONDS_OF_10, 10);
      GoalStore.setGoalProgress(TaskType.ADDITION_SINGLE_DIGIT, 5);
      GoalStore.setGoalProgress(TaskType.SUBTRACTION_SINGLE_DIGIT, 0);
      GoalStore.setGoalProgress(TaskType.TIMESTABLE_TO_10, 20);

      GoalStore.setGoal(TaskType.NUMBERBONDS_OF_10, 25);
      GoalStore.setGoal(TaskType.ADDITION_SINGLE_DIGIT, 25);
      GoalStore.setGoal(TaskType.SUBTRACTION_SINGLE_DIGIT, 25);
      GoalStore.setGoal(TaskType.TIMESTABLE_TO_10, 25);
    }
  }
}
