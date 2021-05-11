import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/model/NumberBondStatistics.dart';
import 'package:numberbonds/pages/numberbonds/NumberBondsPage.dart';
import 'package:numberbonds/storage/StatisticsStore.dart';
import 'package:numberbonds/styleguide/buttons/SGButtonRaised.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends BaseState<HomePage> {
  _HomePage() {
    // todo init
  }

  @override
  Widget build(BuildContext context) {
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
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SGButtonRaised(
              text: "Start",
              onPressed: () => {to(context, () => NumberBondsPage())}),
          buildSumStatistics(context),

        ]);
  }

  Widget buildSumStatistics(BuildContext context) {
    return FutureBuilder<NumberBondStatistics>(
      future: StatisticsStore.getSumStatistics(),
        builder: (BuildContext context, AsyncSnapshot<NumberBondStatistics> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // YOUR CUSTOM CODE GOES HERE
            return Text("Correct ${snapshot.data?.correct}\n${snapshot.data?.wrong}\nWrong ${snapshot.data?.wrong}\nTotal ${snapshot.data?.total}");

          } else {
            return new CircularProgressIndicator();
          }
        }
    );
  }
}
