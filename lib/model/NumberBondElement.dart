import 'package:numberbonds/model/NumberBondElementType.dart';

class NumberBondElement {
  final NumberBondElementType type;
  final String? text;

  NumberBondElement({
    required this.type,
    this.text,
  });

}