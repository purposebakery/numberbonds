import 'package:numberbonds/utils/DartUtils.dart';
import 'package:vibration/vibration.dart';

class VibrateUtils {
  static Future<void> vibrate() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: DartUtils.DURATION_MEDIUM.inMilliseconds);
    }
  }
}
