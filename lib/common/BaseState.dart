import 'package:flutter/widgets.dart';
import 'package:numberbonds/utils/navigationutils.dart';

abstract class BaseState<T extends StatefulWidget> extends State {
  to(BuildContext context, Widget Function() function) {
    NavigationUtils.to(context, function);
  }

  back(BuildContext context) {
    NavigationUtils.back(context);
  }
}
