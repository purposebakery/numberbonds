import 'dart:math';

class NumberBond {
  int first = -1;
  int second = -1;
  int result = -1;

  NumberBond.base10() {
    result = 10;
    first = Random().nextInt(8) + 1;
    second = result - first;
  }

  bool isSecond(int? second) {
    return this.second == second;
  }
}