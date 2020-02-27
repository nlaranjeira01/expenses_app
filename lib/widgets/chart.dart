import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;

        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }

        return {
          "day": DateFormat.E("pt_BR").format(weekDay)[0].toUpperCase(),
          "amount": totalSum,
        };
      },
    ).reversed.toList();
  }

  double get maxSpending => groupedTransactionValues.fold(
      0.0,
      (double sum, Map<String, Object> item) =>
          (item["amount"] as double) > sum ? (item["amount"] as double) : sum);

  @override
  Widget build(BuildContext context) {
    print(maxSpending);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (Map<String, Object> grp) => Expanded(
                  child: ChartBar(
                    grp["day"],
                    grp["amount"],
                    maxSpending == 0.0
                        ? 0.0
                        : ((grp["amount"] as double) / maxSpending),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
