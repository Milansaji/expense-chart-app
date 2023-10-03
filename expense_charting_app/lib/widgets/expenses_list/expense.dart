import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

final formatter = DateFormat(DateFormat.YEAR_MONTH_DAY);
const uuid = Uuid();

enum Category { food, travel, work, leisure, other }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.other: Icons.person
};

class Expense {
  Expense(
      {required this.amount,
      required this.category,
      required this.date,
      required this.title})
      : id = uuid.v4();

  final String id;

  final String title;

  final double amount;

  final DateTime date;

  final Category category;

  String get formatted_date {
    return formatter.format(date);
  }
}

class Expensecart {
  Expensecart({required this.category, required this.expenses});
  Expensecart.forcategory(List<Expense> allexpense, this.category)
      : expenses = allexpense
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalexpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
