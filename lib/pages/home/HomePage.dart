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
import 'package:numberbonds/utils/SystemUtils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends BaseState<HomePage> {
  final ValueNotifier<GoalState> goal = ValueNotifier<GoalState>(GoalState());

  @override
  Widget build(BuildContext context) {
    buildState(context);

    reload();
    return Scaffold(
      appBar: AppBar(
        title: Text('Number bonds of 10'),
        actions: [buildInfoActions()],
      ),
      body: buildBody(context),
    );
  }

  Widget buildInfoActions() {
    return IconButton(
      icon: Icon(Icons.info_outline, color: SGColors.textInverse,),
      onPressed: () {
        showInfoMessage();
      },
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


  Widget buildStartButton() {
    return SGButtonRaised(
      text: "Start",
      padding: EdgeInsets.only(top: SGSizes.SPACE3_D, bottom: SGSizes.SPACE3_D),
      onPressed: () => {navigateToNumberBondsPage()},
    );
  }


  Widget buildGoalContainer(BuildContext context) {
    return Expanded(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildGoal(context),
        buildGoalButtons(context),
      ]),
    );
    //return buildGoalSettingsButton();
  }

  Widget buildGoal(BuildContext context) {
    return ValueListenableBuilder<GoalState>(
      builder: (BuildContext context, GoalState goalState, Widget? child) {
        var text = "Daily goal \n${goalState.goalProgress} / ${goalState.goal}";
        if (goalState.goalProgressPerunus >= 1) {
          text = "Daily goal\nreached!";
        }
        return Padding(
            padding:
                const EdgeInsets.only(left: SGSizes.SPACE1, right: SGSizes.SPACE1, bottom: SGSizes.SPACE2, top: SGSizes.SPACE2),
            child: SGGoalCircularProgress(
                radius: SystemUtils.getDisplayShortestSideHalf(context),
                progress: goalState.goalProgressPerunus,
                text: text));
      },
      valueListenable: this.goal,
    );
  }

  Widget buildGoalButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [buildGoalSettingsButton(context), buildGoalIncreaseButton(context), buildGoalDecreaseButton(context)],
    );
  }

  Widget buildGoalSettingsButton(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: SGColors.text,
        ),
        onPressed: () => {goalSettingsButtonClicked(context)});
  }

  Widget buildGoalIncreaseButton(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_circle_up,
          color: SGColors.text,
        ),
        onPressed: () => {goalIncreaseButtonClicked(context)});
  }

  Widget buildGoalDecreaseButton(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_circle_down,
          color: SGColors.text,
        ),
        onPressed: () => {goalDecreaseButtonClicked(context)});
  }

  // Logic
  navigateToNumberBondsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NumberBondsPage()),
    ).then((value) => reload());
  }

  goalSettingsButtonClicked(BuildContext context) {
    SGAlertDialogParameters parameters = SGAlertDialogParameters();
    parameters.title = "Reset goal?";
    parameters.message = "Do you want to reset your daily goal?";
    parameters.positiveButton = "Yes";
    parameters.negativeButton = "Cancel";
    parameters.positiveCallback = () => {GoalStore.resetGoalProgress(), reload()};
    SGAlertDialog.showSGAlertDialog(context, parameters);
  }

  goalIncreaseButtonClicked(BuildContext context) {
    GoalStore.increaseGoal();
    reload();
  }

  goalDecreaseButtonClicked(BuildContext context) {
    GoalStore.decreaseGoal();
    reload();
  }

  reload() {
    setState(() {
      GoalStore.getGoalState().then((value) => this.goal.value = value);
    });
  }

  showInfoMessage() {

    SGAlertDialogParameters parameters = SGAlertDialogParameters();
    parameters.title = "Hi there!";
    parameters.message = "I'm Oliver. I believe in free education so I develop free educational apps (sounds logical right?). If you feel like supporting me, even only a small donation would absolutely make my day!";
    parameters.positiveButton = "Donate";
    parameters.negativeButton = "Not today ;)";
    parameters.positiveCallback = () => {openDonateUrl()};
    SGAlertDialog.showSGAlertDialog(context, parameters);
  }

  openDonateUrl() {
    SGAlertDialogParameters parameters = SGAlertDialogParameters();
    parameters.isParentalGate = true;
    parameters.title = "Parental gate";
    parameters.message = "<p><a href=\"https://buymeacoffee.com/purposebakery\">Please</a> press the first word of this sentence to continue. This is a parental gate to make sure kids do not end up on the donation page. Thanks!</p>";
    parameters.negativeButton = "Cancel";
    parameters.positiveButton = "Ok";
    SGAlertDialog.showSGAlertDialog(context, parameters);
  }
}
