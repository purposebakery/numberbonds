import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/model/GoalState.dart';
import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondBase10.dart';
import 'package:numberbonds/model/NumberBondElementType.dart';
import 'package:numberbonds/storage/GoalStore.dart';
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

  bool initialised = false;
  int? resultInput;
  late double numberPadItemWidth;
  late NumberBond numberbond;
  late bool waitingForReset;
  late GoalType goalType;

  final ValueNotifier<GoalState> goal = ValueNotifier<GoalState>(GoalState());

  _NumberBondsPageState() {
    GoalStore.getGoalType().then((value) => initializeValues(value));
  }

  void initializeValues(GoalType type) {
    this.goalType = type;
    this.resultInput = UNDEFINED;
    this.numberbond = createNumberBond();
    this.numberbond.generateWithPrevious(this.numberbond);
    this.waitingForReset = false;
    GoalStore.getGoalStateCurrent().then((value) => this.goal.value = value);

    setState(() {
      this.initialised = true;
    });
  }

  NumberBond createNumberBond(){
    switch (goalType) {
      case GoalType.EASY:
        return NumberBondBase10();
      case GoalType.MEDIUM:
        return NumberBondBase10(); // TODO create new NumberBond
      case GoalType.DIFFICULT:
        return NumberBondBase10(); // TODO create new NumberBond
    }
  }

  void _resetWithDelayAndLockUi() {
    this.waitingForReset = true;
    DartUtils.delay(DartUtils.DURATION_1SEC, () {
      _reset();
    });
  }

  void _reset() {
    setState(() {
      initializeValues(this.goalType);
    });
  }

  void _setResultInput(int resultInput) {
    // Same input. Ignore.
    if (this.resultInput == resultInput) {
      return;
    }

    // We're waiting for a reset. Ignore
    if (this.waitingForReset) {
      return;
    }

    // Set the state
    setState(() {
      if (this.numberbond.isResult(resultInput)) {
        // Right Answer
        // TODO add statistic again
        //StatisticsStore.storeNumberBondResult(this.numberbond, NumberBondResult.CORRECT);
        GoalStore.addGoalProgressCurrent();

        this.resultInput = resultInput;
        _resetWithDelayAndLockUi();
      } else {
        // Wrong answer
        // TODO add statistic again
        // StatisticsStore.storeNumberBondResult(this.numberbond, NumberBondResult.WRONG);
        VibrateUtils.vibrate();

        this.resultInput = resultInput;
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

    if (initialised.not) {
      return Text("");
    }

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("${goalType.name} Number Bonds"),
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
    if (resultInput != UNDEFINED) {
      resultNumberFormatted = resultInput.toString();
    }

    List<Widget> expressionWidgets = List.empty(growable: true);
    numberbond.getElements().forEach((element) {
      if (element.type == NumberBondElementType.EMPTY) {
          expressionWidgets.add(buildEquationResultNumber(context, resultNumberFormatted));
      } else {
        expressionWidgets.add(buildEquationNumber(context, element.text ?? " "));
      }
    });

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: expressionWidgets);
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
    if (waitingForReset && resultInput.toString() == number) {
      if (numberbond.isResult(resultInput)) {
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
                _setResultInput(int.parse(number));
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
