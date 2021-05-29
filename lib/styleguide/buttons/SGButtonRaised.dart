import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';

class SGButtonRaised extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  SGButtonRaised({Key? key, required this.text, required this.onPressed, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        child: Text(text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5!.apply(color: SGColors.textInverse)),
        color: SGColors.action,
        padding: padding,
        onPressed: onPressed);
  }
}
