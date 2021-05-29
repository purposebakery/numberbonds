import 'package:flutter/material.dart';
import 'package:numberbonds/styleguide/constants/SGColors.dart';

class SGAlertDialog {
  static Future<void> showSGAlertDialog(BuildContext context, SGAlertDialogParameters parameters) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: parameters.dismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(parameters.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: generateContent(context, parameters),
            ),
          ),
          actions: generateActions(context, parameters),
        );
      },
    );
  }

  static List<Widget> generateContent(BuildContext context, SGAlertDialogParameters parameters) {
    var content = List<Widget>.empty(growable: true);
    if (parameters.message != null) {
      content.add(Text(parameters.message!));
    }
    return content;
  }

  static List<Widget> generateActions(BuildContext context, SGAlertDialogParameters parameters) {
    var actions = List<Widget>.empty(growable: true);
    if (parameters.negativeButton != null) {
      actions.add(TextButton(
        child: Text(parameters.negativeButton!),
        onPressed: () {
          Navigator.of(context).pop();
          if (parameters.negativeCallback != null) {
            parameters.negativeCallback!();
          }
        },
      ));
    }
    if (parameters.positiveButton != null) {
      actions.add(TextButton(
        child: Text(
          parameters.positiveButton!,
          style: TextStyle(color: SGColors.textInverse),
        ),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(SGColors.action)),
        onPressed: () {
          Navigator.of(context).pop();
          if (parameters.positiveCallback != null) {
            parameters.positiveCallback!();
          }
        },
      ));
    }

    return actions;
  }
}

class SGAlertDialogParameters {
  bool dismissible = true;
  String title = "";
  String? message;
  String? positiveButton;
  Function? positiveCallback;
  String? negativeButton;
  Function? negativeCallback;
}
