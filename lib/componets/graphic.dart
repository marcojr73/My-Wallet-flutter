import 'package:flutter/material.dart';
import 'package:mywallet/componets/MoneyBar.dart';
import 'package:mywallet/models/transaction.dart';
import 'package:intl/intl.dart';

class Graphic extends StatelessWidget {
  const Graphic(this.lastTrasactions, {super.key});

  final List<Transaction> lastTrasactions;

  List<Map<String, Object>> get listLastTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final initialWeeDay = DateFormat.E().format(weekDay)[0];

      double totalSum = 0.00;

      for (var i = 0; i < lastTrasactions.length; i++) {
        bool someDay = lastTrasactions[i].date.day == weekDay.day;
        bool someMonth = lastTrasactions[i].date.month == weekDay.month;
        bool someYear = lastTrasactions[i].date.year == weekDay.year;

        if (someDay && someMonth && someYear) {
          totalSum += lastTrasactions[i].value;
        }
      }

      final ans = {"day": initialWeeDay, "value": totalSum};

      return ans;
    }).reversed.toList();
  }

  double get weekTotalValue {
    return listLastTransactions.fold(0, (sum, e) {
      return sum + e.cast()["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: listLastTransactions.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: MoneyBar(
                e.cast()["value"],
                weekTotalValue == 0 ? 0 : e.cast()["value"] / weekTotalValue,
                e.cast()["day"],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
