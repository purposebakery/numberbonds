import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';
import 'package:numberbonds/styleguide/constants/SGSizes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SGGoalCircularProgress extends StatelessWidget {
  final double progress;
  final String text;

  SGGoalCircularProgress({Key? key, required this.progress, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new CircularPercentIndicator(
      radius: 200.0,
      lineWidth: Sizes.ICON_SMALL,
      percent: progress,
      center: new Text(text,
          textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1!.apply(color: SGColors.text)),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: SGColors.green,
    );
  }
}
