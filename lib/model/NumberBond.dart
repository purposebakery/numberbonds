import 'package:numberbonds/model/NumberBondElement.dart';
import 'package:numberbonds/model/NumberBondResult.dart';

class NumberBond {
  NumberBond generateWithPrevious(NumberBond previous) { return NumberBond();}

  NumberBondResult checkResult(int? result) {return NumberBondResult.CORRECT;}

  List<NumberBondElement> getElements() { return List.empty(); }
}