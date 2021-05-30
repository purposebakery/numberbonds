import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';
import 'package:numberbonds/styleguide/constants/SGSizes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SGGoalProgress extends StatelessWidget {
  final double progress;
  final String text;

  SGGoalProgress({Key? key, required this.progress, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new LinearPercentIndicator(
      lineHeight: Sizes.ICON_SMALL,
      percent: progress,
      //animation: true,
      center: Text(text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.apply(color: SGColors.textInverse)),
      progressColor: SGColors.green,
      backgroundColor: SGColors.grey,
    );
  }
}