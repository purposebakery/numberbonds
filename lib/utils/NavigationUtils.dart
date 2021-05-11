import 'package:flutter/material.dart';

class NavigationUtils {
  static to(BuildContext context, Widget Function() function) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => function.call()),
    );
  }

  static back(BuildContext context) {
    Navigator.pop(context);
  }
}