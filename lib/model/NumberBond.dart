import 'dart:math';

import 'package:numberbonds/pages/App.dart';

class NumberBond {
  int first = -1;
  int second = -1;
  int result = -1;

  NumberBond.empty();

  NumberBond.base10WithPrevious(NumberBond previous) {
    while (first == -1 || previous.first == first) {
      base10();
    }
  }

  void base10() {
    result = 10;
    first = Random().nextInt(8) + 1;
    if (App.SCREENSHOT_MODE) {
      first = 4;
    }
    second = result - first;
  }

  bool isSecond(int? second) {
    return this.second == second;
  }

  String toString() {
    return "$first,$second,$result";
  }

  NumberBond fromString(String string) {
    List<String> values = string.split(',');
    first = int.parse(values[0]);
    second = int.parse(values[1]);
    result = int.parse(values[2]);
    return this;
  }
}
