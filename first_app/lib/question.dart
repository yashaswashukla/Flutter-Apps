/**
 * This is a custom Widget and can be used in place of Text in the main app, as it is implementing the
 * functionality of the Text Widget
 */

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(
          15), //this is an object and it is a constructor not an enum
      child: Text(
        questionText,
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign
            .center, //Here this TextAlign is an Enum so we can directly specify the value of it
      ),
    );
  }
}
