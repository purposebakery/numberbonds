import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/model/GoalState.dart';
import 'package:numberbonds/pages/numberbonds/NumberBondsPage.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/styleguide/buttons/SGButtonRaised.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';
import 'package:numberbonds/styleguide/constants/SGSizes.dart';
import 'package:numberbonds/styleguide/dialogs/SGAlertDialog.dart';
import 'package:numberbonds/styleguide/progress/SGGoalCircularProgress.dart';
import 'package:numberbonds/styleguide/progress/SGGoalProgress.dart';

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
        title: Text('Numberbonds of 10'),
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
      text: "Start",
      padding: EdgeInsets.only(top: Sizes.SPACE4, bottom: Sizes.SPACE4),
      onPressed: () => {navigateToNumberBondsPage()},
    );
  }

  Widget buildGoalContainer(BuildContext context) {
    return Column(children: [
      //buildGoal(),
      buildGoal(),
      buildGoalSettingsButton(context),
    ]);
    //return buildGoalSettingsButton();
  }

  Widget buildGoal() {
    return FutureBuilder<GoalState>(
        future: GoalStore.getGoalState(),
        builder: (BuildContext context, AsyncSnapshot<GoalState> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            var text =
                "Daily goal \n${snapshot.data!.goalProgress} / ${snapshot.data!.goal}";
            return Padding(
                padding: const EdgeInsets.only(
                    left: Sizes.SPACE1,
                    right: Sizes.SPACE1,
                    bottom: Sizes.SPACE2,
                    top: Sizes.SPACE2),
                child: SGGoalCircularProgress(
                    progress: snapshot.data!.goalProgressPerunus, text: text));
          } else {
            return SGGoalProgress(progress: 0, text: "");
          }
        });
  }

  Widget buildGoalSettingsButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.delete_outline,
        color: SGColors.text,),
        onPressed: () => {
          settingsButtonClicked(context)
        });
  }

  settingsButtonClicked(BuildContext context) {
    SGAlertDialogParameters parameters = SGAlertDialogParameters();
    parameters.title = "Reset goal?";
    parameters.message = "Do you want to reset your daily goal?";
    parameters.positiveButton = "Confirm";
    parameters.negativeButton = "Cancel";
    parameters.positiveCallback = ()=>{
      GoalStore.resetGoalProgress(),
      reload()
    };
    SGAlertDialog.showSGAlertDialog(context, parameters);
  }
}
