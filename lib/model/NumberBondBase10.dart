import 'dart:math';

import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondElement.dart';
import 'package:numberbonds/model/NumberBondElementType.dart';
import 'package:numberbonds/model/NumberBondResult.dart';
import 'package:numberbonds/pages/App.dart';

class NumberBondBase10 implements NumberBond {
  int _first = -1;
  int _second = -1;
  int _result = -1;

  @override
  NumberBond generateWithPrevious(NumberBond? previous) {
    while (_first == -1 || (previous as NumberBondBase10)._first == _first) {
      _generate();
    }
    return this;
  }

  void _generate() {
    _result = 10;
    _first = Random().nextInt(8) + 1;
    if (App.SCREENSHOT_MODE) {
      _first = 4;
    }
    _second = _result - _first;
  }

  @override
  NumberBondResult checkResult(int? result) {
    if (this._second == result) {
      return NumberBondResult.CORRECT;
    } else {
      return NumberBondResult.WRONG;
    }
  }

  @override
  List<NumberBondElement> getElements() {
    var list = List<NumberBondElement>.empty(growable: true);
    list.add(NumberBondElement(type: NumberBondElementType.INTEGER, text: "$_first"));
    list.add(NumberBondElement(type: NumberBondElementType.OPERATOR, text: "+"));
    list.add(NumberBondElement(type: NumberBondElementType.EMPTY));
    list.add(NumberBondElement(type: NumberBondElementType.EQUALS, text: "="));
    list.add(NumberBondElement(type: NumberBondElementType.INTEGER, text: "$_result"));
    return list;
  }
}
