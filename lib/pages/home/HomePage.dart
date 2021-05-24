import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/model/NumberBondStatistics.dart';
import 'package:numberbonds/pages/numberbonds/NumberBondsPage.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/storage/StatisticsStore.dart';
import 'package:numberbonds/styleguide/buttons/SGButtonRaised.dart';
import 'package:numberbonds/styleguide/progress/SGGoalProgress.dart';
import 'package:numberbonds/styleguide/progress/SGRelationshipProgress.dart';

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
          buildStartButton(),
          buildSumStatistics(context),
          buildGoalContainer(context),
        ]);
  }

  void navigateToNumberBondsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NumberBondsPage()),
    ).then((value) => reload());
  }

  void reload() {
    setState(() {});
  }

  Widget buildStartButton() {
    return SGButtonRaised(
        text: "Start", onPressed: () => {navigateToNumberBondsPage()});
  }

  Widget buildSumStatistics(BuildContext context) {
    return FutureBuilder<NumberBondStatistics>(
        future: StatisticsStore.getSumStatistics(),
        builder: (BuildContext context,
            AsyncSnapshot<NumberBondStatistics> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // YOUR CUSTOM CODE GOES HERE
            return SGRelationshipProgress(
                left: snapshot.data?.correct.toDouble() ?? 0,
                right: snapshot.data?.wrong.toDouble() ?? 0);
            return Text(
                "Correct ${snapshot.data?.correct}\nWrong ${snapshot.data?.wrong}\nTotal ${snapshot.data?.total}");
          } else {
            return new CircularProgressIndicator();
          }
        });
  }

  Widget buildGoalContainer(BuildContext context) {
    return Row(children: [
      //buildGoal(),
      //buildGoalSettingsButton()
    ]);
  }

  Widget buildGoal() {
    return FutureBuilder<double>(
        future: GoalStore.getGoalProgressPerunus(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SGGoalProgress(progress: snapshot.data!);
          } else {
            return SGGoalProgress(progress: 0);
          }
        });
  }

  Widget buildGoalSettingsButton() {
    return IconButton(
        icon: Icon(Icons.admin_panel_settings), onPressed: () => {
        showGoalDialog()
    });
  }

  Future<void> showGoalDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Goal Settings'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Set your daily goal!')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                GoalStore.resetGoalProgress();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
