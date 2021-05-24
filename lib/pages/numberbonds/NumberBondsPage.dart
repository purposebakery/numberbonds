import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/model/NumberBond.dart';
import 'package:numberbonds/model/NumberBondResult.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/storage/StatisticsStore.dart';
import 'package:numberbonds/styleguide/constants/Sizes.dart';
import 'package:numberbonds/styleguide/buttons/SGButtonRaised.dart';
import 'package:numberbonds/styleguide/progress/SGGoalProgress.dart';
import 'package:numberbonds/utils/DartUtils.dart';

class NumberBondsPage extends StatefulWidget {
  NumberBondsPage({Key? key}) : super(key: key);

  @override
  _NumberBondsPageState createState() => _NumberBondsPageState();
}

class _NumberBondsPageState extends BaseState<NumberBondsPage> {
  static const int UNDEFINED = -1;

  int? secondInput;
  late double numberPadItemWidth;
  late NumberBond numberbond;
  late bool waitingForReset;

  final ValueNotifier<double> goal = ValueNotifier<double>(0);

  _NumberBondsPageState() {
    initializeValues();
  }

  void initializeValues() {
    this.secondInput = UNDEFINED;
    this.numberbond = NumberBond.base10(); // TODO generate one different that current
    this.waitingForReset = false;
    GoalStore.getGoalProgressPerunus().then((value) => this.goal.value = value);
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
        GoalStore.addGoalProgress();

        this.secondInput = secondInput;
        this.waitingForReset = true;
        DartUtils.delay(DartUtils.DURATION_2SEC, () {
          _reset();
        });
      } else {
        // Wrong answer
        StatisticsStore.storeNumberBondResult(this.numberbond, NumberBondResult.WRONG);
        _reset();
      }
    });
  }

  void prebuild() {
    //double width = SystemUtils.getDisplayShortestSide(context);
    numberPadItemWidth = Sizes.ICON_LARGE;
  }

  @override
  Widget build(BuildContext context) {
    prebuild();
    return Scaffold(
      appBar: AppBar(
        title: Text('Numberbonds'),
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
        buildNumberPad(context),
        new Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              buildGoalProgress(context),
              buildEquation(context),
              buildEquationCheckResponse(),
            ])),
      ],
    );
  }

  /*
  Widget buildGoalProgress(BuildContext context) {
    return FutureBuilder<double>(
        future: GoalStore.getGoalProgressPerunus(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.only(left: Sizes.SPACE1, right: Sizes.SPACE1, bottom: Sizes.SPACE2, top : Sizes.SPACE2),
              child: SGGoalProgress(progress: snapshot.data!),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: Sizes.SPACE1, right: Sizes.SPACE1, bottom: Sizes.SPACE2, top : Sizes.SPACE2),
              child: SGGoalProgress(progress: 0),
            );
          }
        }
    );
  }*/

  Widget buildGoalProgress(BuildContext context) {
    return ValueListenableBuilder<double>(
        builder: (BuildContext context, double value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(left: Sizes.SPACE1, right: Sizes.SPACE1, bottom: Sizes.SPACE2, top : Sizes.SPACE2),
            child: SGGoalProgress(progress: value),
          );
        },
      valueListenable: this.goal,
    );
  }

  Widget buildStopButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.SPACE1),
      child: SGButtonRaised(text: "Finish", onPressed: () => {back(context)}),
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
      buildNumberPadNumber(context, resultNumberFormatted),
      buildEquationNumber(context, "="),
      buildEquationNumber(context, "${numberbond.result}"),
    ]);
  }

  Widget buildEquationCheckResponse() {
    bool visible = numberbond.isSecond(secondInput);
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      // If the widget is hidden, animate to 1.0 (fully visible).
      opacity: visible ? 1.0 : 0.0,
      curve: Curves.decelerate,
      duration: DartUtils.DURATION_MEDIUM,
      child: buildEquationCheckResponseIcon(),
    );
    /*
    return Visibility(
        visible: numberbond.isSecond(secondInput),
        replacement: SizedBox(height: Sizes.ICON_LARGE),
        maintainState: false,
        child: SizedBox(
          width: Sizes.ICON_LARGE,
          height: Sizes.ICON_LARGE,
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: Sizes.ICON_LARGE,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          //Lottie.asset('assets/check_lottie.json', repeat: false),
        ));*/
  }

  Widget buildEquationCheckResponseIcon() {
    return Icon(
      Icons.check,
      color: Colors.green,
      size: Sizes.ICON_LARGE,
      semanticLabel: 'Text to announce in accessibility modes',
    );
  }

  Widget buildEquationNumber(BuildContext context, String number) {
    return Container(
      height: Sizes.ICON_MEDIUM,
      width: Sizes.ICON_MEDIUM,
      child: buildNumberField(context, number),
    );
  }

  Widget buildNumberPad(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.SPACE2, top: Sizes.SPACE2),
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
    return Padding(
        padding: EdgeInsets.all(5),
        child: OutlinedButton(
            onPressed: () {
              _setSecondInput(int.parse(number));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (_) => Size(numberPadItemWidth, numberPadItemWidth)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(numberPadItemWidth / 2.0),
                        side: BorderSide(color: Colors.red)))),
            child: buildNumberField(context, number)));
  }

  Widget buildNumberField(BuildContext context, String number) {
    return AnimatedSwitcher(
        duration: DartUtils.DURATION_SHORT,
        child: Text(number,
            key: ValueKey<int>(number.hashCode),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .apply(color: Colors.grey.shade800)));
  }
}
