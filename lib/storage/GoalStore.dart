import 'dart:math';

import 'package:numberbonds/model/GoalState.dart';
import 'package:numberbonds/utils/DateUtils.dart';
import 'package:numberbonds/utils/ToastUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GoalType {
  EASY, MEDIUM, DIFFICULT
}

extension GoalTypeExtension on GoalType {
  String get name {
    switch (this) {
      case GoalType.EASY:
        return 'Easy';
      case GoalType.MEDIUM:
        return 'Medium';
      case GoalType.DIFFICULT:
        return 'Difficult';
      default:
        return '';
    }
  }
}

class GoalStore {
  static const int GOAL_DEFAULT = 25;
  static const int GOAL_MAX = 1000;
  static const int GOAL_PROGRESS_DEFAULT = 0;

  static const String KEY_GOAL_TYPE = "KEY_GOAL_TYPE";
  static const String KEY_GOAL = "KEY_GOAL";
  static const String KEY_GOAL_PROGRESS = "KEY_GOAL_PROGRESS";
  static const String KEY_GOAL_PROGRESS_DAY = "KEY_GOAL_PROGRESS_DAY";

  static Future<GoalType> getGoalType() async {
    final prefs = await SharedPreferences.getInstance();
    var keyGoalTypeString = prefs.getString(KEY_GOAL_TYPE) ?? GoalType.EASY.toString();
    for(var type in GoalType.values) {
      if (type.toString() == keyGoalTypeString) {
        return type;
      }
    }
    return GoalType.EASY;
  }

  static Future<void> setGoalType(GoalType type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_GOAL_TYPE, type.toString());
  }

  static Future<void> storeGoal(GoalType type, int goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL + type.toString(), goal);
  }

  static Future<int> getGoal(GoalType type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_GOAL + type.toString()) ?? GOAL_DEFAULT;
  }

  static Future<void> setGoal(GoalType type, int goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL + type.toString(), goal);
  }

  static Future<void> increaseGoalCurrent() async {
    _increaseGoal(await getGoalType());
  }

  static Future<void> _increaseGoal(GoalType type) async {
    final prefs = await SharedPreferences.getInstance();
    var goal = prefs.getInt(KEY_GOAL + type.toString()) ?? GOAL_DEFAULT;
    if (goal >= GOAL_MAX) {
      ToastUtils.toastLong("I think that's enough . . .");
    } else {
      prefs.setInt(KEY_GOAL + type.toString(), goal + 5);
    }
  }

  static Future<void> decreaseGoalCurrent() async {
    _decreaseGoal(await getGoalType());
  }

  static Future<void> _decreaseGoal(GoalType type) async {
    final prefs = await SharedPreferences.getInstance();
    var goal = prefs.getInt(KEY_GOAL + type.toString()) ?? GOAL_DEFAULT;
    if (goal > 5) {
      prefs.setInt(KEY_GOAL + type.toString(), goal - 5);
    } else {
      ToastUtils.toastLong("That's the minimum . . .");
    }
  }

  static Future<void> addGoalProgressCurrent() async {
    _addGoalProgress(await getGoalType());
  }

  static Future<void> _addGoalProgress(GoalType type) async {
    final prefs = await SharedPreferences.getInstance();
    var progress = prefs.getInt(KEY_GOAL_PROGRESS + type.toString()) ?? GOAL_PROGRESS_DEFAULT;
    prefs.setInt(KEY_GOAL_PROGRESS + type.toString(), ++progress);
  }

  static Future<void> setGoalProgress(GoalType type, int goalProgress) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL_PROGRESS + type.toString(), goalProgress);
  }

  static Future<void> resetGoalProgressCurrent() async {
    _resetGoalProgress(await getGoalType());
  }

  static Future<void> _resetGoalProgress(GoalType type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEY_GOAL_PROGRESS + type.toString(), 0);
  }

  static Future<void> resetGoalProgressIfNewDay(GoalType type) async {
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

  static Future<int> getGoalProgress(GoalType type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_GOAL_PROGRESS + type.toString()) ?? GOAL_PROGRESS_DEFAULT;
  }

  static Future<GoalState> getGoalStateCurrent() async {
    return getGoalState(await getGoalType());
  }

  static Future<GoalState> getGoalState(GoalType type) async {
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
