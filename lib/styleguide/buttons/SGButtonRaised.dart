import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:numberbonds/styleguide/constants/Sizes.dart';

class SGButtonRaised extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  SGButtonRaised({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .apply(color: Colors.white)
        ),
        color: Colors.teal,
        padding: EdgeInsets.only(top: Sizes.SPACE1, bottom: Sizes.SPACE2),
        onPressed: onPressed);
  }
}
