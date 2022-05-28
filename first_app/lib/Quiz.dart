import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import './Answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final Function answerUpdater;
  final List<Map<String, Object>> questions;
  final int questionIndex;
  Quiz(this.answerUpdater, this.questions, this.questionIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'] as String,
        ), //Our custom Widget
        //Now, We will try to create answer Widget dynamically with the help of the list we have
        //Here we are mapping the list of objects to a list of Widgets with the help of the .map()
        //map() takes a function as an argument, so we pass an annonymus function and pass the values
        //through it
        //We return the Widget from the map() as we need a list of Widgets
        //Now, we get an error that map does not work for Object type but we only have a List of strings
        //as the
        //argument so we tell Dart that this is a list of strings using as List<String>
        //Now this map returns a Iteratable, which is a parent class of all the Iteratble.
        //So, We convert it to a List using .toList()
        //But, This creates a nested list as We already have a list of widgets in the Column
        //Hence we use '...' spread operator, which takes out the elements from a list and
        //gives them individually. Which will solve our problem of getting a nested list
        //Note: map() does not modify the original list, it creates a new list
        ...(questions[questionIndex]['answer'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
              () => answerUpdater(answer['score']), answer['text'] as String);
          //Now, to update the score we have to pass the score in the answerUpdater function but we cannot because that will inititate
          //the answerUpdater function, So We create an annonymus function, now the address of that annonymus function is passed on to
          //Answer and inside that annonymus function we call the answerUpdater with the score initiated
        }).toList()
      ],
    );
  }
}
