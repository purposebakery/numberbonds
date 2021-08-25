import 'dart:math';

import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondElement.dart';
import 'package:numberbonds/model/NumberBondElementType.dart';
import 'package:numberbonds/pages/App.dart';

class NumberBondBase10 implements NumberBond {
  int _first = -1;
  int _second = -1;
  int _result = -1;

  NumberBond generateWithPrevious(NumberBond? previous) {
    while (_first == -1 || (previous as NumberBondBase10)._first == _first) {
      base10();
    }
    return this;
  }

  void base10() {
    _result = 10;
    _first = Random().nextInt(8) + 1;
    if (App.SCREENSHOT_MODE) {
      _first = 4;
    }
    _second = _result - _first;
  }

  bool isResult(int? result) {
    return this._second == _second;
  }

  String toString() {
    return "$_first,$_second,$_result";
  }

  NumberBond fromString(String string) {
    List<String> values = string.split(',');
    _first = int.parse(values[0]);
    _second = int.parse(values[1]);
    _result = int.parse(values[2]);
    return this;
  }

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
