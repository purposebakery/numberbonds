import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/model/GoalState.dart';
import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondResult.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/storage/StatisticsStore.dart';
import 'package:numberbonds/styleguide/buttons/SGButtonRaised.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';
import 'package:numberbonds/styleguide/constants/SGSizes.dart';
import 'package:numberbonds/styleguide/progress/SGGoalLinearProgress.dart';
import 'package:numberbonds/utils/DartUtils.dart';
import 'package:numberbonds/utils/VibrateUtils.dart';

class NumberBondsPage extends StatefulWidget {
  NumberBondsPage({Key? key}) : super(key: key);

  @override
  _NumberBondsPageState createState() => _NumberBondsPageState();
}

class _NumberBondsPageState extends BaseState<NumberBondsPage> {
  static const int UNDEFINED = -1;

  int? secondInput;
  late double numberPadItemWidth;
  late NumberBond numberbond = NumberBond.empty();
  late bool waitingForReset;

  final ValueNotifier<GoalState> goal = ValueNotifier<GoalState>(GoalState());

  _NumberBondsPageState() {
    initializeValues();
  }

  void initializeValues() {
    this.secondInput = UNDEFINED;
    this.numberbond = NumberBond.base10WithPrevious(this.numberbond);
    this.waitingForReset = false;
    GoalStore.getGoalStateCurrent().then((value) => this.goal.value = value);
  }

  void _resetWithDelayAndLockUi() {
    this.waitingForReset = true;
    DartUtils.delay(DartUtils.DURATION_1SEC, () {
      _reset();
    });
  }

  void _reset() {
    setState(() {
      initializeValues();
    });
  }

  void _setSecondInput(int secondInput) {
    // Same input. Ignore.
    if (this.secondInput == secondInput) {
      return;
    }

    // We're waiting for a reset. Ignore
    if (this.waitingForReset) {
      return;
    }

    // Set the state
    setState(() {
      if (this.numberbond.isSecond(secondInput)) {
        // Right Answer
        StatisticsStore.storeNumberBondResult(this.numberbond, NumberBondResult.CORRECT);
        GoalStore.addGoalProgressCurrent();

        this.secondInput = secondInput;
        _resetWithDelayAndLockUi();
      } else {
        // Wrong answer
        StatisticsStore.storeNumberBondResult(this.numberbond, NumberBondResult.WRONG);
        VibrateUtils.vibrate();

        this.secondInput = secondInput;
        _resetWithDelayAndLockUi();
      }
    });
  }

  void prebuild() {
    numberPadItemWidth = SGSizes.ICON_LARGE_D;
  }

  @override
  Widget build(BuildContext context) {
    buildState(context);
    prebuild();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Number bonds of 10'),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildStopButton(context),
        buildGoalProgress(context),
        new Expanded(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          buildEquation(context),
          buildNumberPad(context),
        ])),
      ],
    );
  }

  Widget buildGoalProgress(BuildContext context) {
    return ValueListenableBuilder<GoalState>(
      builder: (BuildContext context, GoalState goalState, Widget? child) {
        var text = "";
        if (goalState.goalProgressPerunus >= 1) {
          text = "Daily goal reached!";
        } else {
          text = "${goalState.goalProgress} / ${goalState.goal}";
        }
        return Padding(
          padding: EdgeInsets.only(left: SGSizes.SPACE2_D, right: SGSizes.SPACE2_D, bottom: SGSizes.SPACE1_D, top: 0),
          child: SGGoalProgress(progress: goalState.goalProgressPerunus, text: text),
        );
      },
      valueListenable: this.goal,
    );
  }

  Widget buildStopButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SGSizes.SPACE1),
      child: SGButtonRaised(
          text: "Finish",
          padding: EdgeInsets.only(top: SGSizes.SPACE1_D, bottom: SGSizes.SPACE1_D),
          onPressed: () => {back(context)}),
    );
  }

  Widget buildEquation(BuildContext context) {
    String resultNumberFormatted = " ";
    if (secondInput != UNDEFINED) {
      resultNumberFormatted = secondInput.toString();
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildEquationNumber(context, "${numberbond.first}"),
      buildEquationNumber(context, "+"),
      buildEquationResultNumber(context, resultNumberFormatted),
      buildEquationNumber(context, "="),
      buildEquationNumber(context, "${numberbond.result}"),
    ]);
  }

  Widget buildEquationCheckResponseIcon() {
    return Icon(
      Icons.check,
      color: SGColors.green,
      size: SGSizes.ICON_LARGE,
      semanticLabel: 'Right answer!',
    );
  }

  Widget buildEquationNumber(BuildContext context, String number) {
    return Container(
      height: SGSizes.ICON_MEDIUM,
      width: SGSizes.ICON_MEDIUM,
      child: buildNumberField(context, number),
    );
  }

  Widget buildNumberPad(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SGSizes.SPACE2_D),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNumberPadNumber(context, "1"),
            buildNumberPadNumber(context, "2"),
            buildNumberPadNumber(context, "3"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNumberPadNumber(context, '4'),
            buildNumberPadNumber(context, '5'),
            buildNumberPadNumber(context, '6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNumberPadNumber(context, '7'),
            buildNumberPadNumber(context, '8'),
            buildNumberPadNumber(context, '9'),
          ],
        ),
      ]),
    );
  }

  Widget buildNumberPadNumber(BuildContext context, String number) {
    Color color;
    if (waitingForReset && secondInput.toString() == number) {
      if (secondInput == numberbond.second) {
        color = SGColors.greenLight;
      } else {
        color = SGColors.redLight;
      }
    } else {
      color = Colors.transparent;
    }
    return Padding(
        padding: EdgeInsets.all(SGSizes.SPACE0_25),
        child: AnimatedSwitcher(
          duration: DartUtils.DURATION_LONG,
          child: MaterialButton(
              onPressed: () {
                _setSecondInput(int.parse(number));
              },
              highlightElevation: 0.0,
              elevation: 0.0,
              minWidth: numberPadItemWidth,
              height: numberPadItemWidth,
              color: color,
              shape: buildRoundedBorder(),
              child: buildNumberField(context, number)),
        ));
  }

  Widget buildEquationResultNumber(BuildContext context, String number) {
    return Padding(
        padding: EdgeInsets.all(SGSizes.SPACE0_25),
        child: Container(
            width: numberPadItemWidth,
            height: numberPadItemWidth,
            decoration: ShapeDecoration(shape: buildRoundedBorder()),
            child: buildNumberField(context, number)));
  }

  RoundedRectangleBorder buildRoundedBorder() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(numberPadItemWidth / 2.0),
        side: BorderSide(color: SGColors.greyLight, width: 1.0));
  }

  Widget buildNumberField(BuildContext context, String number) {
    return AnimatedSwitcher(
        duration: DartUtils.DURATION_SHORT,
        child: Text(number,
            key: ValueKey<int>(number.hashCode),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4!.apply(color: SGColors.text)));
  }
}
