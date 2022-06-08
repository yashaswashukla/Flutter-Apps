import 'package:calculator/Widget/Button.dart';
import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var userQuestion = "Hello";
  var userAnswer = "Answer";

  final List<String> buttons = [
    "C",
    "Del",
    "%",
    "/",
    "7",
    "8",
    "9",
    "X",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "Ans",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      padding: EdgeInsets.all(25),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userQuestion,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(25),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return myButton(
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.black,
                    );
                  } else if (index == 1) {
                    return myButton(
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.black,
                    );
                  } else {
                    return myButton(
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.deepOrange
                          : Color.fromARGB(255, 255, 242, 223),
                      textColor: isOperator(buttons[index])
                          ? Colors.black
                          : Colors.deepOrange,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == 'X' || x == '-' || x == '+' || x == '=' || x == '/')
      return true;

    return false;
  }
}
