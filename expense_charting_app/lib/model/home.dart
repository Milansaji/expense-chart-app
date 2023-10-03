import 'package:expense_charting_app/model/chart/chart.dart';

import 'package:expense_charting_app/widgets/expenses_list/expense.dart';
import 'package:expense_charting_app/widgets/expenses_list/expense_list.dart';
import 'package:expense_charting_app/widgets/expenses_list/newexpense.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Expense> addedExpense = [];

  void addExpenses() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => newexpense(onaddexpense: addnewexpenses));
  }

  void addnewexpenses(Expense expense) async {
    setState(() {
      addedExpense.add(expense);
    });
  }

  void removeexpense(Expense expense) {
    final expenseindex = addedExpense.indexOf(expense);
    setState(() {
      addedExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense removed'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              addedExpense.insert(expenseindex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget screencontent = Center(
      child: Text('No expense found try to add some'),
    );
    if (addedExpense.isNotEmpty) {
      screencontent = expensesList(
        expenses: addedExpense,
        onremoveexpense: removeexpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PERSONAL EXPENSE TRACKER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: addExpenses, icon: Icon(Icons.add))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Chart(expenses: addedExpense),
            Expanded(child: screencontent),
          ],
        ),
      ),
    );
  }
}
