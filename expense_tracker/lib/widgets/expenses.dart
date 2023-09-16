import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> regexp = [
    Expense(
        title: 'Flutter Course',
        amount: 20.11,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cimena',
        amount: 15.34,
        date: DateTime.now(),
        category: Category.leisure)
  ];
  void _addExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: addExpense,
      ),
    );
  }

  void addExpense(Expense expense) {
    setState(
      () {
        regexp.add(expense);
      },
    );
  }

  void removeExpense(Expense expense) {
    final index = regexp.indexOf(expense);
    setState(() {
      regexp.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              regexp.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expenses in the list"),
    );
    if (regexp.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: regexp,
        onRemoved: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _addExpensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          SafeArea(
              child: Chart(
            expense: regexp,
          )),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
