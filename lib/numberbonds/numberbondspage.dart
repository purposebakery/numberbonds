import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/utils/systemutils.dart';

class NumberBondsPage extends StatefulWidget {
  NumberBondsPage({Key key}) : super(key: key);

  @override
  _NumberBondsPageState createState() => _NumberBondsPageState();
}

class _NumberBondsPageState extends State<NumberBondsPage> {
  int _counter = 0;
  double numberPadItemWidth;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            buildEquation(context),
            buildNumberPad(context)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildEquation(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildEquationNumber(context, "8"),
      buildEquationNumber(context, "+"),
      buildEquationNumber(context, "_"),
      buildEquationNumber(context, "="),
      buildEquationNumber(context, "10"),
    ]);
  }

  Widget buildEquationNumber(BuildContext context, String number) {
    return Text(
      number,
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Widget buildNumberPad(BuildContext context) {
    return Column(children: [
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
    ]);
  }

  Widget buildNumberPadNumber(BuildContext context, String number) {
    return 
      Padding(padding: EdgeInsets.all(5), child: OutlinedButton(
        onPressed: () {
          // Respond to button press
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.resolveWith((_) => Size(numberPadItemWidth, numberPadItemWidth)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(numberPadItemWidth / 2.0),
                  side: BorderSide(color: Colors.red)
              )
          )
        ),
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.apply(
            color: Colors.grey.shade800
          )
        )));
  }
}
