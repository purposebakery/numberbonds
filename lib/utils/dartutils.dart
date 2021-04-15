class DartUtils {

  static const int DURATION_SHORT_MILLIS = 150;
  static const int DURATION_MEDIUM_MILLIS = 300;
  static const int DURATION_LONG_MILLIS = 600;

  static const int DURATION_1SEC_MILLIS = 1000;

  static const Duration DURATION_SHORT = Duration(milliseconds: DURATION_SHORT_MILLIS);
  static const Duration DURATION_MEDIUM = Duration(milliseconds: DURATION_MEDIUM_MILLIS);
  static const Duration DURATION_LONG = Duration(milliseconds: DURATION_LONG_MILLIS);

  static const Duration DURATION_1SEC = Duration(milliseconds: DURATION_1SEC_MILLIS * 1);
  static const Duration DURATION_2SEC = Duration(milliseconds: DURATION_1SEC_MILLIS * 2);

  static void delay(Duration duration, Function function) {
    Future.delayed(duration, function);
  }

  static void delayShort(Function function) {
    delay(DURATION_SHORT, function);
  }

  static void delayMedium(Function function) {
    delay(DURATION_MEDIUM, function);
  }

  static void delayLong(Function function) {
    delay(DURATION_LONG, function);
  }
}
