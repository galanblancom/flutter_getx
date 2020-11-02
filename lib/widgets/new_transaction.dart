import 'package:flutter/material.dart';
import 'package:flutter_example/controllers/transaction_controller.dart';
import 'package:flutter_example/models/transaction.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatelessWidget {
  void _submitData(TransactionController controller, BuildContext context) {
    if (controller.amount.isEmpty) {
      return;
    }
    final enteredTitle = controller.title;
    final enteredAmount = double.parse(controller.amount);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || controller.date == null) {
      return;
    }

    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: enteredTitle,
        amount: enteredAmount,
        date: controller.date);

    controller.addTransaction(newTransaction);

    //Navigator.of(context).pop();
    Get.back();

    //bloc.changeTitle('');
    //bloc.changeAmount('');
    controller.changeDate(null);
  }

  void _presentDatePicker(TransactionController controller, BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      controller.changeDate(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GetBuilder<TransactionController>(
                  init: TransactionController(),
                  builder: (_) {
                    return TextField(
                      decoration: InputDecoration(labelText: 'Título'),
                      onChanged: _.changeTitle,
                      onSubmitted: (d) => _submitData(_, context),
                    );
                  }),
              GetBuilder<TransactionController>(
                  init: TransactionController(),
                  builder: (_) {
                    return TextField(
                      decoration: InputDecoration(labelText: 'Monto'),
                      onChanged: _.changeAmount,
                      keyboardType: TextInputType.number,
                      onSubmitted: (d) => _submitData(_, context),
                    );
                  }),
              GetBuilder<TransactionController>(
                  init: TransactionController(),
                  builder: (_) {
                    return Container(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(_.date == null
                                ? 'No ha seleccionado una fecha!'
                                : 'Picked date: ' +
                                    DateFormat('dd/MM/yyyy').format(_.date)),
                          ),
                          FlatButton(
                            onPressed: () => _presentDatePicker(_, context),
                            child: Text(
                              'Seleccionar fecha',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            textColor: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    );
                  }),
              GetBuilder<TransactionController>(
                  init: TransactionController(),
                  builder: (_) {
                    return RaisedButton(
                        child: Text('Agregar gasto'),
                        textColor: Theme.of(context).textTheme.button.color,
                        color: Theme.of(context).primaryColor,
                        onPressed: () => _submitData(_, context));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
