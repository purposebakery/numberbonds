import 'package:flutter/widgets.dart';

class SystemUtils {
  static double getDisplaySizeWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDisplaySizeWidthHalf(BuildContext context) {
    return getDisplaySizeWidth(context) / 2.0;
  }

  static double getDisplaySizeHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getDisplaySizeHeightHalf(BuildContext context) {
    return getDisplaySizeHeight(context) / 2.0;
  }

  static Size getDisplaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getDisplayShortestSide(BuildContext context) {
    return getDisplaySize(context).shortestSide;
  }

  static double getDisplayShortestSideHalf(BuildContext context) {
    return getDisplayShortestSide(context) / 2.0;
  }
}
