import 'dart:math';

import 'package:numberbonds/model/GoalState.dart';
import 'package:numberbonds/model/TaskType.dart';
import 'package:numberbonds/utils/DateUtils.dart';
import 'package:numberbonds/utils/ToastUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalStore {
  static const int GOAL_DEFAULT = 25;
  static const int GOAL_MAX = 1000;
  static const int GOAL_PROGRESS_DEFAULT = 0;

  static const String KEY_TASK_TYPE = "KEY_TASK_TYPE";
  static const String KEY_GOAL = "KEY_GOAL";
  static const String KEY_GOAL_PROGRESS = "KEY_GOAL_PROGRESS";
  static const String KEY_GOAL_PROGRESS_DAY = "KEY_GOAL_PROGRESS_DAY";

  static Future<TaskType> getTaskType() async {
    final prefs = await SharedPreferences.getInstance();
    var key = prefs.getString(KEY_TASK_TYPE) ?? TaskType.NUMBERBONDS_OF_10.toString();
    for(var type in TaskType.values) {
      if (type.toString() == key) {
        return type;
      }
    }
    return TaskType.NUMBERBONDS_OF_10;
  }

  static Future<void> setTaskType(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_TASK_TYPE, type.toString());
  }

  static Future<void> storeGoal(TaskType type, int goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL + type.toString(), goal);
  }

  static Future<int> getGoal(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_GOAL + type.toString()) ?? GOAL_DEFAULT;
  }

  static Future<void> setGoal(TaskType type, int goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL + type.toString(), goal);
  }

  static Future<void> increaseGoalCurrent() async {
    _increaseGoal(await getTaskType());
  }

  static Future<void> _increaseGoal(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    var goal = prefs.getInt(KEY_GOAL + type.toString()) ?? GOAL_DEFAULT;
    if (goal >= GOAL_MAX) {
      ToastUtils.toastLong("I think that's enough . . .");
    } else {
      prefs.setInt(KEY_GOAL + type.toString(), goal + 5);
    }
  }

  static Future<void> decreaseGoalCurrent() async {
    _decreaseGoal(await getTaskType());
  }

  static Future<void> _decreaseGoal(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    var goal = prefs.getInt(KEY_GOAL + type.toString()) ?? GOAL_DEFAULT;
    if (goal > 5) {
      prefs.setInt(KEY_GOAL + type.toString(), goal - 5);
    } else {
      ToastUtils.toastLong("That's the minimum . . .");
    }
  }

  static Future<void> addGoalProgressCurrent() async {
    _addGoalProgress(await getTaskType());
  }

  static Future<void> _addGoalProgress(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    var progress = prefs.getInt(KEY_GOAL_PROGRESS + type.toString()) ?? GOAL_PROGRESS_DEFAULT;
    prefs.setInt(KEY_GOAL_PROGRESS + type.toString(), ++progress);
  }

  static Future<void> setGoalProgress(TaskType type, int goalProgress) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL_PROGRESS + type.toString(), goalProgress);
  }

  static Future<void> resetGoalProgressCurrent() async {
    _resetGoalProgress(await getTaskType());
  }

  static Future<void> _resetGoalProgress(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL_PROGRESS + type.toString(), 0);
  }

  static Future<void> resetGoalProgressIfNewDay(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    var progressDay = prefs.getString(KEY_GOAL_PROGRESS_DAY + type.toString());
    var today = DateUtils.getFormatted(DateTime.now());
    if (today != progressDay) {
      // Day has changed
      _resetGoalProgress(type);
    } else {
      // Day is the same no need to do anything
    }
    prefs.setString(KEY_GOAL_PROGRESS_DAY + type.toString(), today);
  }

  static Future<int> getGoalProgress(TaskType type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_GOAL_PROGRESS + type.toString()) ?? GOAL_PROGRESS_DEFAULT;
  }

  static Future<GoalState> getGoalStateCurrent() async {
    return getGoalState(await getTaskType());
  }

  static Future<GoalState> getGoalState(TaskType type) async {
    var goal = await getGoal(type);
    var goalProgress = await getGoalProgress(type);
    var goalProgressPerunus = max(min(goalProgress.toDouble() / goal.toDouble(), 1), 0).toDouble();
    var goalState = GoalState();
    goalState.goal = goal;
    goalState.goalProgress = goalProgress;
    goalState.goalProgressPerunus = goalProgressPerunus;

    return goalState;
  }
}
