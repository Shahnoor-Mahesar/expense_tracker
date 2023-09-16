import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, required this.expense});
  final List<Expense> expense;
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final BoxShape _boxShape = BoxShape.circle;

  int size = 0;

  @override
  Widget build(BuildContext context) {
    double total = 0;
    Map<String, double> dataMap = {
      Category.food.name.toUpperCase():
          ExpenseBucket.forCategory(widget.expense, Category.food).totalExpense,
      Category.leisure.name.toUpperCase():
          ExpenseBucket.forCategory(widget.expense, Category.leisure)
              .totalExpense,
      Category.travel.name.toUpperCase():
          ExpenseBucket.forCategory(widget.expense, Category.travel)
              .totalExpense,
      Category.work.name.toUpperCase():
          ExpenseBucket.forCategory(widget.expense, Category.work).totalExpense,
    };
    dataMap.forEach((key, value) {
      total += value;
    });
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      //colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: total.toStringAsFixed(2),
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: _boxShape,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
