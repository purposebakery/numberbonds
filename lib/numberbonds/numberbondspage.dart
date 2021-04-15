import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/common/sizes.dart';
import 'package:numberbonds/maths/numberbond.dart';
import 'package:numberbonds/utils/dartutils.dart';
import 'package:numberbonds/utils/systemutils.dart';
import 'package:lottie/lottie.dart';

class NumberBondsPage extends StatefulWidget {
  NumberBondsPage({Key key}) : super(key: key);

  @override
  _NumberBondsPageState createState() => _NumberBondsPageState();
}

class _NumberBondsPageState extends State<NumberBondsPage> {
  static const int UNDEFINED = -1;

  int secondInput;
  double numberPadItemWidth;
  NumberBond numberbond;
  bool waitingForReset;

  _NumberBondsPageState(){
    initializeValues();
  }

  void initializeValues() {
    this.secondInput = UNDEFINED;
    this.numberbond = NumberBond.base10(); // TODO generate one different that current
    this.waitingForReset = false;
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
      this.secondInput = secondInput;
      if (this.numberbond.isSecond(secondInput)) {
        this.waitingForReset = true;
        DartUtils.delay(DartUtils.DURATION_2SEC, () {
          _reset();
        });
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
      children: <Widget>[
        buildNumberPad(context),
        buildEquation(context)
      ],
    );
  }

  Widget buildEquation(BuildContext context) {
    String resultNumberFormatted = " ";
    if (secondInput != UNDEFINED) {
      resultNumberFormatted = secondInput.toString();
    }

    return Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildEquationNumber(context, "${numberbond.first}"),
            buildEquationNumber(context, "+"),
            buildNumberPadNumber(context, resultNumberFormatted),
            buildEquationNumber(context, "="),
            buildEquationNumber(context, "${numberbond.result}"),
          ]),
              Visibility(
                  visible: numberbond.isSecond(secondInput),
                  replacement: SizedBox(height: Sizes.ICON_LARGE),
                  maintainState: false,
                  child: SizedBox(
                width: Sizes.ICON_LARGE,
                height: Sizes.ICON_LARGE,
                child: Lottie.asset('assets/check_lottie.json', repeat: false),
              ))


        ]));
  }

  Widget buildEquationNumber(BuildContext context, String number) {
    return Container(
      height: Sizes.ICON_MEDIUM,
      width: Sizes.ICON_MEDIUM,
      child: Text(
        number,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline4
            .apply(color: Colors.grey.shade800),
      ),
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
            child: buildNumberField(context, number)
        )
    );
  }

  Widget buildNumberField(BuildContext context, String number){
    return AnimatedSwitcher(
        duration: DartUtils.DURATION_SHORT,
        child: Text(number,
            key: ValueKey<int>(number.hashCode),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .apply(color: Colors.grey.shade800))
    );
  }
}
