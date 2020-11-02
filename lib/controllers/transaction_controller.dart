import 'package:flutter_example/controllers/validators.dart';
import 'package:get/get.dart';

import '../models/transaction.dart';
import '../models/transaction.dart';

class TransactionController extends GetxController with Validators {
  RxString _title = ''.obs; //.obs.stream.transform(validarTitle);
  RxDouble _amount = 0.0.obs;
  Rx<DateTime> _date = DateTime.now().obs;
  RxList<Transaction> _transactions = List<Transaction>().obs;

  String get title => _title.value;
  double get amount => _amount.value;
  DateTime get date => _date.value;
  List<Transaction> get userTransactions => _transactions;
  List<Transaction> get recentTransactions =>
      _transactions.where((transaction) {
        return transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();

  void changeTitle(String title) {
    this._title.value = title;
  }

  void changeAmount(double amount) {
    this._amount.value = amount;
  }

  void changeDate(DateTime date) {
    this._date.value = date;
  }

  void addTransaction(Transaction t) {
    this._transactions.add(t);
  }

  void deleteTransaction(String id) {
    this._transactions.removeWhere((transaction) {
      return transaction.id == id;
    });
  }
}
