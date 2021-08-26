import 'package:numberbonds/model/NumberBondElement.dart';
import 'package:numberbonds/model/NumberBondResult.dart';

class NumberBond {
  int _first = -1;
  int _second = -1;
  int _result = -1;

  NumberBond generateWithPrevious(NumberBond previous) { return NumberBond();}

  NumberBondResult checkResult(int? result) {return NumberBondResult.CORRECT;}

  List<NumberBondElement> getElements() { return List.empty(); }
}