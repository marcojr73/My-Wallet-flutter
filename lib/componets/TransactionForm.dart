import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) addTransaction;

  const TransactionForm(this.addTransaction, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final valueController = TextEditingController();
  final titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  validateData() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0) return;

    widget.addTransaction(title, value, selectedDate);
  }

  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) return null;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: valueController,
              onSubmitted: (e) => validateData(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Value"),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == DateTime.now() ? 
                        DateFormat("d/M/y").format(DateTime.now()).toString()
                      :
                        DateFormat("d/M/y").format(selectedDate).toString()
                      ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker, 
                    child: Text(
                      "alterar data",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    )
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary)
                  ),
                  onPressed: () => validateData(),
                  child: const Text(
                    "New Transaction",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
