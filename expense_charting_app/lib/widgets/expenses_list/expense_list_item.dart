import 'package:expense_charting_app/widgets/expenses_list/expense.dart';

import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({required this.expense, super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\RS.${expense.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expense.category]),
                    SizedBox(
                      width: 8,
                    ),
                    Text(expense.formatted_date)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
