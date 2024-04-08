import 'package:dsa_tracker_app/components/track/questiondetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionTileCardWidget extends StatelessWidget {
  final String questionName;
  final String questionType;
  final String timeComplexity;
  final String spaceComplexity;
  final String notes;
  final String difficulty;
  final int attempts;
  final String questionLink;

  QuestionTileCardWidget({
    required this.questionName,
    required this.questionType,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.notes,
    required this .difficulty,
    required this.attempts,
    required this.questionLink
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      borderOnForeground: false,
      color: Color.fromARGB(77, 11, 19, 72),
      child: ListTile(
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      questionName,
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        color: Colors.white),

                    ),
                  Text(
                    '$questionType',
                    style: GoogleFonts.manrope(
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                      ),
                  ),
                ],
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailedQuestionCard(
                      questionName: questionName,
                      questionType: questionType,
                      timeComplexity: timeComplexity,
                      spaceComplexity: spaceComplexity,
                      notes: notes,
                      difficulty: difficulty,
                      attempts: attempts,
                      questionLink: questionLink
                    )),
                  );                },
                icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

