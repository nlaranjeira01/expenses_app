import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteTransaction;

  TransactionList(this.transactionList, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "Nenhuma transação adicionada ainda!",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child:
                    Image.asset("assets/images/waiting.png", fit: BoxFit.cover),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (BuildContext ctx, int index) => Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(
                      child: Text("R\$${transactionList[index].amount}"),
                    ),
                  ),
                ),
                title: Text(
                  transactionList[index].title,
                  style: Theme.of(ctx).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat.yMMMd("pt_BR").format(transactionList[index].date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTransaction(transactionList[index].id),
                ),
              ),
            ),
            itemCount: transactionList.length,
          );
  }
}
