import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:numberbonds/common/BaseState.dart';
import 'package:numberbonds/common/sizes.dart';
import 'package:numberbonds/maths/numberbond.dart';
import 'package:numberbonds/numberbonds/numberbondspage.dart';
import 'package:numberbonds/styleguide/buttons/SGButtonRaised.dart';
import 'package:numberbonds/utils/dartutils.dart';
import 'package:numberbonds/utils/navigationutils.dart';

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
              onPressed: () => {to(context, () => NumberBondsPage())})
        ]
    );
  }
}
