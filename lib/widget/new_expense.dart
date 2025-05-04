import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text('please enter valid data'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
      return;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      prefixText: '\$',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No date seleceted'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon((Icons.calendar_month)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items:
                      Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Add Expense'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
