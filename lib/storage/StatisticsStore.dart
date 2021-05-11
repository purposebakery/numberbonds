
import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondResult.dart';
import 'package:numberbonds/model/NumberBondStatistics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsStore {

  static const String KEY_SUM = "KEY_SUM";

  static Future<void> storeNumberBondResult(NumberBond numberBond, NumberBondResult numberBondResult) async {
    // Update sum
    getStatistics(KEY_SUM).then((NumberBondStatistics sum) => {
      updateStatistics(KEY_SUM, sum, numberBondResult)
    });
  }

  static Future<NumberBondStatistics> getSumStatistics() async {
    return getStatistics(KEY_SUM);
  }

  static Future<NumberBondStatistics> getStatistics(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return NumberBondStatistics().fromString(prefs.getString(key) ?? NumberBondStatistics().toString());
  }

  static void updateStatistics(String key, NumberBondStatistics statistics, NumberBondResult numberBondResult) {
    statistics.total = statistics.total + 1;
    switch (numberBondResult) {
      case NumberBondResult.CORRECT:
        statistics.correct = statistics.correct + 1;
        break;
      case NumberBondResult.WRONG:
        statistics.wrong = statistics.wrong + 1;
        break;
    }

    putStatistics(key, statistics);
  }

  static putStatistics(String key, NumberBondStatistics numberBondStatistics) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, numberBondStatistics.toString());
  }
}
