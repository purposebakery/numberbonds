import 'dart:math';

import 'package:numberbonds/model/GoalState.dart';
import 'package:numberbonds/utils/DateUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalStore {
  static const int GOAL_DEFAULT = 25;
  static const int GOAL_PROGRESS_DEFAULT = 0;

  static const String KEY_GOAL = "KEY_GOAL";
  static const String KEY_GOAL_PROGRESS = "KEY_GOAL_PROGRESS";
  static const String KEY_GOAL_PROGRESS_DAY = "KEY_GOAL_PROGRESS_DAY";

  static Future<void> storeGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL, goal);
  }

  static Future<int> getGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_GOAL) ?? GOAL_DEFAULT;
  }

  static Future<void> increaseGoal() async {
    final prefs = await SharedPreferences.getInstance();
    var goal = prefs.getInt(KEY_GOAL) ?? GOAL_DEFAULT;
    prefs.setInt(KEY_GOAL, goal+5);
  }

  static Future<void> decreaseGoal() async {
    final prefs = await SharedPreferences.getInstance();
    var goal = prefs.getInt(KEY_GOAL) ?? GOAL_DEFAULT;
    if (goal > 5) {
      prefs.setInt(KEY_GOAL, goal-5);
    }
  }

  static Future<void> addGoalProgress() async {
    final prefs = await SharedPreferences.getInstance();
    var progress = prefs.getInt(KEY_GOAL_PROGRESS) ?? GOAL_PROGRESS_DEFAULT;
    prefs.setInt(KEY_GOAL_PROGRESS, ++progress);
  }

  static Future<void> resetGoalProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL_PROGRESS, 0);
  }

  static Future<void> resetGoalProgressIfNewDay() async {
    final prefs = await SharedPreferences.getInstance();
    var progressDay = prefs.getString(KEY_GOAL_PROGRESS_DAY);
    var today = DateUtils.getFormatted(DateTime.now());
    if (today != progressDay) {
      // Day has changed
      resetGoalProgress();
    } else {
      // Day is the same no need to do anything
    }
    prefs.setString(KEY_GOAL_PROGRESS_DAY, today);
  }

  static Future<int> getGoalProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_GOAL_PROGRESS) ?? GOAL_PROGRESS_DEFAULT;
  }

  static Future<GoalState> getGoalState() async {
    var goal = await getGoal();
    var goalProgress = await getGoalProgress();
    var goalProgressPerunus = max(min(goalProgress.toDouble() / goal.toDouble(), 1),0).toDouble();
    var goalState = GoalState();
    goalState.goal = goal;
    goalState.goalProgress = goalProgress;
    goalState.goalProgressPerunus = goalProgressPerunus;

    return goalState;
  }


}
