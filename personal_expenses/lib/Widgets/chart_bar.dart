import 'dart:async';

import 'package:flutter/material.dart';

class chartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  chartBar(this.label, this.spendingAmount, this.spendingPercentage);
  @override
  Widget build(BuildContext context) {
    // print(spendingPercentage);
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: <Widget>[
          Container(
            height: constraint.maxHeight * .15,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * .05,
          ),
          Container(
            height: constraint.maxHeight * .6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * .05,
          ),
          Container(
            height: constraint.maxHeight * .15,
            child: Text(label),
          ),
        ],
      );
    });
  }
}
