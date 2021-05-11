
import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsStore {

  static const String KEY_SUM = "KEY_SUM";

  Future<void> storeNumberBondResult(NumberBond numberBond, NumberBondResult numberBondResult) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt(KEY_SUM, counter);
  }
}
