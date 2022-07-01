import 'package:flutter/material.dart';

import './models/constants.dart';

class HomePage extends StatelessWidget {
  Constants myConstants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myConstants.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/alarm.png'),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: myConstants.secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Center(
                    child: Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
