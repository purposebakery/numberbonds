import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/common/sizes.dart';
import 'package:numberbonds/utils/systemutils.dart';
import 'package:lottie/lottie.dart';

class NumberBondsPage extends StatefulWidget {
  NumberBondsPage({Key key}) : super(key: key);

  @override
  _NumberBondsPageState createState() => _NumberBondsPageState();
}

class _NumberBondsPageState extends State<NumberBondsPage> {
  int resultNumber = -1;
  double numberPadItemWidth;

  void _setResultNumber(int resultNumber) {
    setState(() {
      this.resultNumber = resultNumber;
    });
  }

  void prebuild() {
    double width = SystemUtils.getDisplayShortestSide(context);
    numberPadItemWidth = width / 5.0;
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
        //SizedBox(height: 98),
      ],
    );
  }

  Widget buildEquation(BuildContext context) {
    String resultNumberFormatted = " ";
    if (resultNumber != -1) {
      resultNumberFormatted = resultNumber.toString();
    }

    return Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildEquationNumber(context, "8"),
            buildEquationNumber(context, "+"),
            buildNumberPadNumber(context, resultNumberFormatted),
            buildEquationNumber(context, "="),
            buildEquationNumber(context, "10"),
          ]),
              Visibility(
                  visible: resultNumber == 3,
                  replacement: SizedBox(height: 128,),
                  child: SizedBox(
                width: 128,
                height: 128,
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
              _setResultNumber(int.parse(number));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (_) => Size(numberPadItemWidth, numberPadItemWidth)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(numberPadItemWidth / 2.0),
                        side: BorderSide(color: Colors.red)))),
            child: Text(number,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .apply(color: Colors.grey.shade800))));
  }
}
