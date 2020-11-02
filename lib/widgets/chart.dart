import 'package:flutter/material.dart';
import 'package:flutter_example/controllers/transaction_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Map<String, Object>> groupedTransactionValues(
      List<Transaction> recentTransactions) {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double totalSpending(List<Transaction> recentTransactions) {
    return groupedTransactionValues(recentTransactions).fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: GetBuilder<TransactionController>(
                init: TransactionController(),
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: groupedTransactionValues(_.recentTransactions)
                        .map((data) {
                      return Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(
                          data['day'],
                          data['amount'],
                          totalSpending(_.recentTransactions) == 0.0
                              ? 0.0
                              : (data['amount'] as double) /
                                  totalSpending(_.recentTransactions),
                        ),
                      );
                    }).toList(),
                  );
                })),
      ),
    );
  }
}