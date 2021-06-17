import 'package:flutter_test/flutter_test.dart';
import 'package:numberbonds/pages/App.dart';

void main() {
  test('Screenshot mode is off', () {
    assert(App.SCREENSHOT_MODE == false);
  });
}
