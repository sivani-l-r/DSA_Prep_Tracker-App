import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StreakHeatMap extends StatelessWidget {
  final List<DateTime> datesWithQuestions;
  final int daysInMonth;
  final int currentMonth;

  const StreakHeatMap({
    Key? key,
    required this.datesWithQuestions,
    required this.daysInMonth,
    required this.currentMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
      ), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Heat Map",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Text(
            DateFormat('MMMM yyyy').format(DateTime(DateTime.now().year, currentMonth)),
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w200,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 4),
          Container( 
            height: 250, 
            
            child: StreakHeatMapContent(
              datesWithQuestions: datesWithQuestions,
              daysInMonth: daysInMonth,
              currentMonth: currentMonth,
            ),
          ),
        ],
      ),
    );
  }
}

class StreakHeatMapContent extends StatelessWidget {
  final List<DateTime> datesWithQuestions;
  final int daysInMonth;
  final int currentMonth;

  const StreakHeatMapContent({
    Key? key,
    required this.datesWithQuestions,
    required this.daysInMonth,
    required this.currentMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        DateTime currentDate = DateTime(DateTime.now().year, currentMonth, index + 1);
        bool hasQuestion = datesWithQuestions.contains(currentDate);
        return Container(
          decoration: BoxDecoration(
            color: hasQuestion ? Colors.green : const Color.fromARGB(255, 193, 216, 227),
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      },
    );
  }
}
