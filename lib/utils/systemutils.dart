import 'package:flutter/widgets.dart';

class SystemUtils{
  static double getDisplaySizeWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDisplaySizeHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Size getDisplaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getDisplayShortestSide(BuildContext context){
    return getDisplaySize(context).shortestSide;
  }
}