

import 'package:flutter/widgets.dart';
import 'package:numberbonds/utils/SystemUtils.dart';

class SGSizes {
  static const double SPACE0_25 = 4;
  static const double SPACE0_5 = 8;
  static const double SPACE1 = 16;
  static const double SPACE2 = 32;
  static const double SPACE3 = 48;
  static const double SPACE4 = 64;

  static double SPACE0_25_D = SPACE0_25; // ignore: non_constant_identifier_names
  static double SPACE0_5_D = SPACE0_5; // ignore: non_constant_identifier_names
  static double SPACE1_D = SPACE1; // ignore: non_constant_identifier_names
  static double SPACE2_D = SPACE2; // ignore: non_constant_identifier_names
  static double SPACE3_D = SPACE3; // ignore: non_constant_identifier_names
  static double SPACE4_D = SPACE4; // ignore: non_constant_identifier_names

  static const double ICON_SMALL = 24;
  static const double ICON_MEDIUM = 48;
  static const double ICON_LARGE = 64;

  static double ICON_SMALL_D = ICON_SMALL; // ignore: non_constant_identifier_names
  static double ICON_MEDIUM_D = ICON_MEDIUM; // ignore: non_constant_identifier_names
  static double ICON_LARGE_D = ICON_LARGE; // ignore: non_constant_identifier_names

  static void initializeDynamic(BuildContext context) {
    var shortestSide = SystemUtils.getDisplayShortestSide(context);
    var dynamicScale = 1.0;
    if (shortestSide <= 320) {
      dynamicScale = 1.0;
    } else if (shortestSide <= 480) {
      dynamicScale = 1.1;
    } else if (shortestSide <= 640) {
      dynamicScale = 1.25;
    } else if (shortestSide <= 800) {
      dynamicScale = 1.45;
    } else {
      dynamicScale = 1.75;
    }

    print("shortestSide: " + shortestSide.toString());
    print("dynamicScale: " + dynamicScale.toString());

    SGSizes.SPACE0_25_D = SPACE0_25 * dynamicScale;
    SGSizes.SPACE0_5_D = SPACE0_5 * dynamicScale;
    SGSizes.SPACE1_D = SPACE1 * dynamicScale;
    SGSizes.SPACE2_D = SPACE2 * dynamicScale;
    SGSizes.SPACE3_D = SPACE3 * dynamicScale;
    SGSizes.SPACE4_D = SPACE4 * dynamicScale;

    SGSizes.ICON_SMALL_D = ICON_SMALL * dynamicScale;
    SGSizes.ICON_MEDIUM_D = ICON_MEDIUM * dynamicScale;
    SGSizes.ICON_LARGE_D = ICON_LARGE * dynamicScale;
  }
}
