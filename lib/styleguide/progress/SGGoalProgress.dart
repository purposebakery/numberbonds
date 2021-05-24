import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SGGoalProgress extends StatelessWidget {
  final double progress;

  SGGoalProgress({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new LinearPercentIndicator(
      lineHeight: 8.0,
      percent: progress,
      //animation: true,
      progressColor: Colors.teal,
      backgroundColor: Colors.grey.shade400,
    );
  }
}
