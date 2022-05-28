/**
 * Notes:
 * void main() {
  runApp(myApp());
}
* Other method to call the main function in the dart

 * There are two types of arguments
 * 1) Named Arguments: Passed with a name. Example: Demo(name: Manu, age: 30) & void Demo({var name, var Age})
 * 2) Positoned Arguments: Passed with the respect of postion in the original function defined. Example: void Demo(var name, var age)
 *    Demo(Manu, 20);


* Example of a List in Dart. This is a list of text similarly we can have a list of widgets as well
* var quuestion = ['What\'s your fav color', 'Hello how are you'];
 * List: In Dart List are an object and there indexing is also 0 based and if we have to access anything from the list we have to type
 * listName.elementAt(indexOfElement) or listName[indexOfElement]; Example is below in the code
 

* Annonymus Function: A function without any name. We Define it when we only need to call it once and don't need to call it from
  anywhere else
* Example given below in the RaisedButton section  
 
  
 * States in Flutter: Data/Information used by the App
 * Example: App State: Authenticated Users or Loaded Jobs
 * There are two type of widgets
 * 1) Stateless Widgets: They do not have any Internal state, i.e. They cannot change their appereance when the external data is passed.
 *    It also only re renders the UI when the Input data is changed.
 *    Basically, It creates a new widget everytime the external data changes.
 *    It is used more often then the stateFulWidget
 * Example: Text Widgets which only have to give out a particular data

 * 2) Stateful Widgets: They have an Internal State, which changes or reacts to the external data/ Input data.
 *    It can re render the UI when the Input data or the local state changes
 *    It is a combination of 2 classes
 *    We have to use 2 classes because when the widget is rebuilt or re-rendered we do not loose the original state of the code.
 *    class className extends StatefulWidget{ 
        @override
       State<StatefulWidget> createState() {
       // TODO: implement createState
       return classNameState();
      } 
 *    class classNameState extends State <className> {} -> this is the state of the widget
 *    When now widget can be re-rendered without interfering with the state of the app
 

 * To change the state we have to use the setState((){propertyWhichIsChangingState});
 * Without setState(), the Widget does change its property value but it will not re-run the build() method.
 * Hence, the updates aren't reflected on the screen
 * It calls the build of the widget where the changes occurs, it does not re-render the whole UI
 * Flutter is smart and it also does not re-draw all the pixels in that widget, it only changes the changed UI.
 
  
 * If we want that our class is only used inside the file it is created in we can simply rename it to _className from className
 * This makes this class as private and now it can only be accessed inside the file it is created.
 


 * Final: We use Final if a value does'nt change from the time a program runs after initiating it
 *    It is a run-tinme final value, when the code executes we lock the final value.
 * Const: It is compile time constant, It means that while writing the code we know the final value.  
  

 * Dart in memory stores the address of the values in the variable, not the values itself
 * So, const abc=10 & var abc=const[], they mean different things, in the first one address in the variable cannot be changed
 * While in the other we can assign a new object's address to the variable abc but cannot change the previous object's values.
 
 * Example: var question=const [alksjdflk,ajjs]
 *  In this we can assign quesion a new list, question=[kask,kka]
 *  This is okay
 
 * But if const question =[ askldjfkl, ajkks]
 * Then the question=[kakk,hqh] won't work, But question.add(kkahg) will work as we are changing the list and list is not const 

  
*/

import 'package:flutter/material.dart';

import './Result.dart';
import './Quiz.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myAppState();
  }
}

class _myAppState extends State<myApp> {
  //<myApp> this sets the pointer that this state belongs to myApp
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerUpdater(int score) {
    _totalScore += score;

    setState(() {
      //setState takes an annonymus function as it argument and inside it is the property which is changing the state
      _questionIndex++;
    });
    print(_questionIndex);
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override //Just to point out that we are delibretly overridding the build method of the present class
  Widget build(BuildContext context) {
    // return MaterialApp(home: Text('Hello, How are you?'));
    //These are known as positioned arguments
    // changed from var to const, because we should not change the questions. As, they are predefined

    const _questions = [
      //Now this is a list of Maps
      {
        'questionText':
            'What\'s your favourite color', //Map with key value pair and value is a string as well as the key
        'answer': [
          {'text': 'Black', 'score': 10},
          {'text': 'Yellow', 'score': 7},
          {'text': 'Green', 'score': 6},
          {'text': 'White', 'score': 2},
        ] //Map with value as a list of strings
      },

      {
        'questionText': 'What\'s your favourite Animal?',
        'answer': [
          {'text': 'Rabbit', 'score': 4},
          {'text': 'Lion', 'score': 10},
          {'text': 'Panther', 'score': 8},
          {'text': 'Elephant', 'score': 5},
        ]
      },

      {
        'questionText': 'What\'s your favourite food',
        'answer': [
          {'text': 'Pizza', 'score': 1},
          {'text': 'Burger', 'score': 1},
          {'text': 'Noodles', 'score': 1},
          {'text': 'Eggs', 'score': 6},
        ]
      },
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('First App'),
        ),
        // body: Text('This is my app'),
        body: _questionIndex < _questions.length
            ? Quiz(_answerUpdater, _questions,
                _questionIndex) //Entire Quiz has it's own new file
            : Result(_totalScore, _resetQuiz), //Result has it's own new file
        //This is a list of Widget inside a Column, We can also remove <Widget> as we enter the Widgets in list
      ),
    );
    //Scaffold gives the basic structure, color, design of the app
    //AppBar() is a default appbar given by the material.dart file
  }
}
