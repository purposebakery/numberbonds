import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SGRelationshipProgress extends StatelessWidget {
  final double left;
  final Color leftColor;

  final double right;
  final Color rightColor;

  SGRelationshipProgress(
      {Key? key,
      required this.left,
      required this.right,
      this.leftColor = Colors.green,
      this.rightColor = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var total = left + right;
    var progress = left / total;
    return new LinearPercentIndicator(
      lineHeight: 8.0,
      percent: progress,
      progressColor: leftColor,
      backgroundColor: rightColor,
      linearStrokeCap: LinearStrokeCap.butt,
      leading: new Text("Right"),
      trailing: new Text("Wrong"),
    );
  }
}
