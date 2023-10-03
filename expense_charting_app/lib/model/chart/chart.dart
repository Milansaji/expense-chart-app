import 'package:expense_charting_app/model/chart/chart_bar.dart';
import 'package:expense_charting_app/widgets/expenses_list/expense.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<Expensecart> get buckets {
    return [
      Expensecart.forcategory(expenses, Category.food),
      Expensecart.forcategory(expenses, Category.leisure),
      Expensecart.forcategory(expenses, Category.travel),
      Expensecart.forcategory(expenses, Category.work),
      Expensecart.forcategory(expenses, Category.other),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalexpense > maxTotalExpense) {
        maxTotalExpense = bucket.totalexpense;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalexpense == 0
                        ? 0
                        : bucket.totalexpense / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(CategoryIcons[bucket.category],
                          color: isDarkMode ? Colors.white : Colors.white),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
