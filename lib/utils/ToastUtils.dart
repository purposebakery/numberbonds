import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';

class ToastUtils {
  static void toastLong(String message) {
    toast(message, Toast.LENGTH_LONG);
  }

  static void toastShort(String message) {
    toast(message, Toast.LENGTH_SHORT);
  }

  static void toast(String message, Toast toastLength) {
    int length = 0;
    switch (toastLength) {
      case Toast.LENGTH_LONG:
        length = 2;
        break;
      case Toast.LENGTH_SHORT:
        length = 1;
        break;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: length,
        backgroundColor: SGColors.action,
        textColor: SGColors.textInverse,
        fontSize: 16.0);
  }
}
