import 'dart:math';

import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondElement.dart';
import 'package:numberbonds/model/NumberBondElementType.dart';
import 'package:numberbonds/model/NumberBondResult.dart';
import 'package:numberbonds/pages/App.dart';

class NumberBondSubtractionSingleDigit implements NumberBond {
  int _first = -1;
  int _second = -1;
  int _result = -1;

  @override
  NumberBond generateWithPrevious(NumberBond? previous) {
    while (_first == -1 || (previous as NumberBondSubtractionSingleDigit)._first == _first) {
      _generate();
    }
    return this;
  }

  void _generate() {
    var addFirst = Random().nextInt(8) + 1;
    var addSecond = Random().nextInt(8) + 1;
    var addResult = addFirst + addSecond;

    _first = addResult;
    _second = addFirst;
    _result = addSecond;

    if (App.SCREENSHOT_MODE) {
      _first = 14;
      _second = 6;
      _result = 8;
    }
  }

  @override
  NumberBondResult checkResult(int? result) {
    result = result ?? -1;

    if (_result.toString() == result.toString()) {
      return NumberBondResult.CORRECT;
    } else if (_result.toString().startsWith(result.toString())) {
      return NumberBondResult.PARTIAL;
    } else {
      return NumberBondResult.WRONG;
    }
  }

  @override
  List<NumberBondElement> getElements() {
    var list = List<NumberBondElement>.empty(growable: true);
    list.add(NumberBondElement(type: NumberBondElementType.INTEGER, text: "$_first"));
    list.add(NumberBondElement(type: NumberBondElementType.OPERATOR, text: "-"));
    list.add(NumberBondElement(type: NumberBondElementType.INTEGER, text: "$_second"));
    list.add(NumberBondElement(type: NumberBondElementType.EQUALS, text: "="));
    list.add(NumberBondElement(type: NumberBondElementType.EMPTY));
    return list;
  }
}
