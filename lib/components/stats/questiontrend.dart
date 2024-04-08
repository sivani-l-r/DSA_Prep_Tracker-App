// import 'package:flutter/material.dart';
// import 'package:flutter_charts/flutter_charts.dart' as charts;

// // Data model for each data point in the line chart
// class QuestionTrendData {
//   final DateTime date;
//   final String difficulty;
//   final int count;

//   QuestionTrendData(this.date, this.difficulty, this.count);
// }

// class QuestionTrendChart extends StatelessWidget {
//   final List<QuestionTrendData> data;

//   QuestionTrendChart(this.data);

//   @override
//   Widget build(BuildContext context) {
//     // Create a series list representing the data
//     List<charts.Series<QuestionTrendData, DateTime>> seriesList = [
//       charts.Series<QuestionTrendData, DateTime>(
//         id: 'Easy',
//         colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//         domainFn: (QuestionTrendData data, _) => data.date,
//         measureFn: (QuestionTrendData data, _) => data.count,
//         data: data.where((element) => element.difficulty == 'easy').toList(),
//       ),
//       charts.Series<QuestionTrendData, DateTime>(
//         id: 'Difficult',
//         colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//         domainFn: (QuestionTrendData data, _) => data.date,
//         measureFn: (QuestionTrendData data, _) => data.count,
//         data: data.where((element) => element.difficulty == 'difficult').toList(),
//       ),
//       charts.Series<QuestionTrendData, DateTime>(
//         id: 'Hard',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (QuestionTrendData data, _) => data.date,
//         measureFn: (QuestionTrendData data, _) => data.count,
//         data: data.where((element) => element.difficulty == 'hard').toList(),
//       ),
//     ];

//     // Create a line chart
//     return charts.LineChart(
//       seriesList,
//       animationDuration: Duration(milliseconds: 500),
//       chartPadding: charts.EdgeInsets.all(16.0),
//       chartTitle: charts.ChartTitle(
//         'Question Trend by Difficulty',
//         innerPadding: 20.0,
//         textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//       ),
//       xAxis: charts.DateTimeAxisSpec(
//         renderSpec: charts.SmallTickRendererSpec(
//           labelStyle: charts.TextStyleSpec(fontSize: 12),
//         ),
//       ),
//       yAxis: charts.NumericAxisSpec(
//         renderSpec: charts.GridlineRendererSpec(
//           labelStyle: charts.TextStyleSpec(fontSize: 12),
//         ),
//       ),
//     );
//   }
// }
