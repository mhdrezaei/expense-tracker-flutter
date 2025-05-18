import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, leisure, work, other }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.local_activity,
  Category.work: Icons.work,
  Category.other: Icons.category,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  get formattedAmount {
    return '\$${amount.toStringAsFixed(2)}';
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses =
          allExpenses.where((expense) => expense.category == category).toList();
  final List<Expense> expenses;
  final Category category;

  double get totalExpenses {
    double total = 0;
    for (final expense in expenses) {
      total += expense.amount;
    }
    return total;
  }
}

class ExpenseBucketList {
  ExpenseBucketList({required this.expenses});
  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    final Map<Category, List<Expense>> bucketMap = {};
    for (final expense in expenses) {
      if (bucketMap[expense.category] == null) {
        bucketMap[expense.category] = [];
      }
      bucketMap[expense.category]!.add(expense);
    }
    return bucketMap.entries
        .map(
          (entry) => ExpenseBucket(expenses: entry.value, category: entry.key),
        )
        .toList();
  }
}
