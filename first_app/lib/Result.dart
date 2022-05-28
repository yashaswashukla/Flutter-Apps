import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetHandler;

  Result(this.score, this.resetHandler);

//Getter is a mixture of a method and property

  String get resultPhrase {
    String resultText;
    if (score <= 8)
      resultText = 'You are Awesome!';
    else if (score <= 12)
      resultText = 'You are pretty likable';
    else if (score <= 16)
      resultText = 'You are ... Strange?!';
    else
      resultText = 'You are Bad!';

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        widthFactor: double.infinity,
        child: Column(
          children: [
            Text(
              'Your Score is: $score',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text('\nYou Completed it!\n $resultPhrase',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            FlatButton(onPressed: resetHandler, child: Text('Restart Quiz'))
          ],
        ));
  }
}
