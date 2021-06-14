import 'package:flutter/widgets.dart';
import 'package:numberbonds/styleguide/constants/SGSizes.dart';
import 'package:numberbonds/utils/NavigationUtils.dart';

abstract class BaseState<T extends StatefulWidget> extends State {
  buildState(BuildContext context) {
    SGSizes.initializeDynamic(context);
  }

  to(BuildContext context, Widget Function() function) {
    NavigationUtils.to(context, function);
  }

  back(BuildContext context) {
    NavigationUtils.back(context);
  }
}
