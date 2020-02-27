import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despesas Pessoais',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purpleAccent,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "Novos tênis",
      amount: 169.99,
      date: DateTime.now().subtract(Duration(days: 0)),
    ),
    Transaction(
      id: "t2",
      title: "Compras semanais",
      amount: 46.53,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: "t3",
      title: "Roupas",
      amount: 120.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "t4",
      title: "Celular de camelô",
      amount: 320.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t5",
      title: "Uber",
      amount: 82.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t6",
      title: "Compras do mês",
      amount: 231.52,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: "t7",
      title: "Cinema",
      amount: 25.00,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((Transaction trs) {
      return trs.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final Transaction trs = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(trs);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((Transaction trs) => trs.id == id);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(fontFamily: "OpenSans"),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
