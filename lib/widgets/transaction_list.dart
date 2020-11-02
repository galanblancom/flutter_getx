import 'package:flutter/material.dart';
import 'package:flutter_example/controllers/transaction_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (_) {
          return Container(
            child: (_.userTransactions.isEmpty)
                ? Column(
                    children: <Widget>[
                      Text(
                        'No hay gastos resgistrados!',
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 200,
                          child: Image.asset(
                            'assets/images/waiting.png',
                            fit: BoxFit.cover,
                          )),
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 8,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                      '\$${_.userTransactions[index].amount.toStringAsFixed(2)}'),
                                ),
                              ),
                            ),
                            title: Text(
                              _.userTransactions[index].title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            subtitle: Text(
                              DateFormat.yMMMd()
                                  .format(_.userTransactions[index].date),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () {
                                  _.deleteTransaction(
                                      _.userTransactions[index].id);
                                })),
                      );
                    },
                    itemCount: _.userTransactions.length,
                  ),
          );
        });
  }
}
