import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? _selectedDate;

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
  }

  void onCreate() {
    //  1 Build an expense
    String title = _titleController.text;
    double amount = 0; 
    Category category = _selectedCategory; 
    if (_selectedDate == null) return;
    DateTime date = _selectedDate!;


    // ignore: unused_local_variable
    Expense newExpense = Expense(
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  void onCancel() {
    // Close the modal
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration:  InputDecoration(
              labelText:'Title',
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButton<Category>(
                  value: _selectedCategory,
                  isExpanded: true,
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 12),

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : DateFormat.yMd().format(_selectedDate!),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

         ElevatedButton(onPressed: onCancel, child: Text("Cancel")), 
         SizedBox(width: 10), 
         ElevatedButton(onPressed: onCreate, child: Text("Create")),
        ],
      ),
    );
  }
}
