import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/model/GoalState.dart';
import 'package:numberbonds/model/TaskType.dart';
import 'package:numberbonds/pages/numberbonds/NumberBondsPage.dart';
import 'package:numberbonds/storage/GoalStore.dart';
import 'package:numberbonds/styleguide/buttons/SGButtonRaised.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';
import 'package:numberbonds/styleguide/constants/SGSizes.dart';
import 'package:numberbonds/styleguide/dialogs/SGAlertDialog.dart';
import 'package:numberbonds/styleguide/progress/SGGoalCircularProgress.dart';
import 'package:numberbonds/styleguide/progress/SGGoalLinearProgress.dart';
import 'package:numberbonds/utils/DartUtils.dart';
import 'package:numberbonds/utils/SystemUtils.dart';
import 'package:numberbonds/utils/ToastUtils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends BaseState<HomePage> {
  final ValueNotifier<Map<TaskType, GoalState>> typeState = ValueNotifier<Map<TaskType, GoalState>>(HashMap());
  final ValueNotifier<GoalState> goal = ValueNotifier<GoalState>(GoalState());
  final ValueNotifier<TaskType> currentType = ValueNotifier<TaskType>(TaskType.NUMBERBONDS_OF_10);

  @override
  Widget build(BuildContext context) {
    buildState(context);

    reload();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Number Bonds"),
        actions: buildActions(),
      ),
      body: buildBody(context),
    );
  }

  List<Widget> buildActions() {
    return [buildDifficultyAction()];
  }

  Widget buildDifficultyAction() {
    return IconButton(
      icon: Icon(
        Icons.speed,
        color: SGColors.textInverse,
      ),
      onPressed: () {
        showDifficultyMenu();
      },
    );
  }

  void showDifficultyMenu() {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(SGSizes.SPACE1),
                child: Text("Change mode", style: Theme.of(context).textTheme.headline6!.apply(color: SGColors.text)),
              ),
              Stack(
                children: [buildDifficultyCells()],
              )
            ]));
  }

  Widget buildDifficultyCells() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildDifficultyCell(TaskType.NUMBERBONDS_OF_10),
        buildDifficultyCell(TaskType.TIMESTABLE_TO_10),
      ],
    );
  }

  Widget buildDifficultySelection() {
    return AnimatedPositioned(
        top: 100,
        child: Icon(
          Icons.chevron_right,
          color: SGColors.text,
        ),
        duration: DartUtils.DURATION_SHORT);
  }

  Widget buildDifficultyCell(TaskType type) {
    Widget selectedIcon;
    if (currentType.value == type) {
      selectedIcon = Icon(
        Icons.chevron_right,
        color: SGColors.text,
      );
    } else {
      selectedIcon = Text("");
    }
    var cellText = type.name;
    double goalProgress = typeState.value[type]?.goalProgressPerunus ?? 0;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: SGSizes.SPACE1, right: SGSizes.SPACE1, top: SGSizes.SPACE1, bottom: SGSizes.SPACE1),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: SGSizes.SPACE1),
              child: Container(width: SGSizes.ICON_SMALL, height: SGSizes.ICON_SMALL, child: selectedIcon),
            ),
            Expanded(child: Text(cellText, style: Theme.of(context).textTheme.subtitle1!.apply(color: SGColors.text))),
            SGGoalProgress(progress: goalProgress, text: "", width: 100),
          ]),
        ),
        Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  splashColor: SGColors.action.withAlpha(150),
                  onTap: () {
                    GoalStore.setTaskType(type);
                    reload();
                    Navigator.pop(context);
                    ToastUtils.toastLong("Mode changed to $cellText");
                  },
                ))),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
        verticalDirection: VerticalDirection.up,
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
            padding: const EdgeInsets.only(
                left: SGSizes.SPACE1, right: SGSizes.SPACE1, bottom: SGSizes.SPACE2, top: SGSizes.SPACE2),
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
    parameters.positiveCallback = () => {GoalStore.resetGoalProgressCurrent(), reload()};
    SGAlertDialog.showSGAlertDialog(context, parameters);
  }

  goalIncreaseButtonClicked(BuildContext context) {
    GoalStore.increaseGoalCurrent();
    reload();
  }

  goalDecreaseButtonClicked(BuildContext context) {
    GoalStore.decreaseGoalCurrent();
    reload();
  }

  reload() {
    setState(() {
      GoalStore.getGoalStateCurrent().then((value) => this.goal.value = value);
      GoalStore.getTaskType().then((value) => this.currentType.value = value);

      this.typeState.value.clear();
      TaskType.values.forEach((type) {
        GoalStore.getGoalState(type).then((value) => this.typeState.value.putIfAbsent(type, () => value));
      });
    });
  }

/*
  // FIXME removed Info action for now... Because apple.
  Widget buildInfoAction() {
    return IconButton(
      icon: Icon(Icons.info_outline, color: SGColors.textInverse,),
      onPressed: () {
        showInfoMessage();
      },
    );
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
  }*/
}
