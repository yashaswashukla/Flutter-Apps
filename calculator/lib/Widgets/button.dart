import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyButton extends StatelessWidget {
  final buttonColor;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton(
      {this.buttonColor,
      required this.buttonText,
      this.textColor,
      this.buttonTapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buttonTapped();
        HapticFeedback.mediumImpact();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
