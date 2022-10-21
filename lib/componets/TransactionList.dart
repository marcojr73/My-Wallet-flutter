import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(int) deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty ? Column(
        children: [
          const Text(
            "No transactions register",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 30),
          Image.asset(
            "./assets/images/waiting.png",
            width: 100,
          )
        ],
      )
      :
      ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final e = transactions[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(child: Text(
                    "R\$ ${e.value.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )),
                ),
              ),
              title: Text(
                e.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                DateFormat("d MMM y").format(e.date)
              ),
              trailing: IconButton(
                onPressed: () => deleteTransaction(e.id), 
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  ),
                ),
            ),
          );
        },
      ),
    );
  }
}
