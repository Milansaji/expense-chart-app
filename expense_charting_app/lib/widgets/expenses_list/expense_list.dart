import 'package:expense_charting_app/widgets/expenses_list/expense.dart';
import 'package:expense_charting_app/widgets/expenses_list/expense_list_item.dart';
import 'package:flutter/material.dart';

class expensesList extends StatelessWidget {
  const expensesList(
      {super.key, required this.expenses, required this.onremoveexpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onremoveexpense;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Dismissible(
          onDismissed: (direction) {
            onremoveexpense(expenses[index]);
          },
          child: ExpenseItem(expense: expenses[index]),
          key: ValueKey(expenses[index]),
          background: Container(
            child: Icon(
              Icons.delete,
              color: isDarkMode
                  ? Colors.black
                  : Theme.of(context).colorScheme.onPrimary,
            ),
            color: isDarkMode
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary,
          ),
        );
      },
      itemCount: expenses.length,
    );
  }
}
