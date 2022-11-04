import 'package:flutter/material.dart';
import 'package:mywallet/componets/TransactionForm.dart';
import 'package:mywallet/componets/TransactionList.dart';
import 'package:mywallet/componets/graphic.dart';
import 'package:mywallet/models/transaction.dart';
import 'dart:math';

main() => runApp(MyWalletApp());

class MyWalletApp extends StatelessWidget {
  MyWalletApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ), 
        textTheme: theme.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> transactions = [];

  List<Transaction> get lastTransactions {
    return transactions.where((e) {
      return e.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  addTransaction(final title, final value, final date) {
    final newTransaction = Transaction(
        id: Random().nextInt(1000),
        title: title,
        value: value,
        date: date
    );
    print(newTransaction);

    setState(() {
      transactions.add(newTransaction);
    });

    print(transactions);

    Navigator.of(context).pop();
  }

  deleteTransaction(int id) {
    setState(() {
      print(transactions[0].id);
      transactions.removeWhere((e) => e.id == id);
    });
  }

  opemTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My wallet'),
        actions: <Widget>[
          IconButton(
              onPressed: () => opemTransactionForm(context),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Graphic(lastTransactions),
            TransactionList(transactions, deleteTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => opemTransactionForm(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
