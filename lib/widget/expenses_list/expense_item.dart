import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final Function(Expense) onDelete;

  const ExpenseItem({super.key, required this.expense, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(categoryIcons[expense.category]),
            ),
            Text(expense.title),
          ],
        ),
        subtitle: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('\$${expense.amount.toStringAsFixed(2)}'),
            ),
            Row(
              spacing: 4,
              children: [
                Icon(Icons.calendar_today),
                Text(expense.formattedDate),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(expense),
        ),
      ),
    );
  }
}
