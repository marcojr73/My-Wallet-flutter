import 'dart:ffi';

import 'package:flutter/material.dart';

class MoneyBar extends StatelessWidget {

  double value;
  double percent;
  String day;

  MoneyBar(this.value, this.percent, this.day, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
              value.toStringAsFixed(2)
            )
          ),
        ),
        const SizedBox(height: 5,),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1
                  ),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5)
                ),
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5,),
        Text(day)
      ],
    );
  }
}