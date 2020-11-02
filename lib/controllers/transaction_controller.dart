import 'package:flutter_example/controllers/validators.dart';
import 'package:get/get.dart';

import '../models/transaction.dart';
import '../models/transaction.dart';

class TransactionController extends GetxController with Validators {
  String _title = ''; //.obs.stream.transform(validarTitle);
  String _amount = '';
  DateTime _date;
  List<Transaction> _transactions = [];

  String get title => _title;
  String get amount => _amount;
  DateTime get date => _date;
  List<Transaction> get userTransactions => _transactions;
  List<Transaction> get recentTransactions =>
      _transactions.where((transaction) {
        return transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();

  void changeTitle(String text) {
    this._title = text;
    update();
  }

  void changeAmount(String text) {
    this._amount = text;
    update();
  }

  void changeDate(DateTime d) {
    this._date = d;
    update();
  }

  void addTransaction(Transaction t) {
    this._transactions.add(t);
    update();
  }

  void deleteTransaction(String id) {
    this._transactions.removeWhere((transaction) {
      return transaction.id == id;
    });
    update();
  }
  //increment() => count++;
}
