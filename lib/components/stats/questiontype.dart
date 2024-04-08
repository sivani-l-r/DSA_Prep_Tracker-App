import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionTypeProgress extends StatefulWidget {
  @override
  _QuestionTypeProgressState createState() => _QuestionTypeProgressState();
}

class _QuestionTypeProgressState extends State<QuestionTypeProgress> {
  Map<String, int> questionCounts = {};

  @override
  void initState() {
    super.initState();
    fetchQuestionCounts();
  }

  Future<void> fetchQuestionCounts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('questions').get();
      Map<String, int> counts = {};
      querySnapshot.docs.forEach((doc) {
        String type = doc['questionType']; 
        counts[type] = (counts[type] ?? 0) + 1;
      });
      setState(() {
        questionCounts = counts;
      });
    } catch (error) {
      print("Error fetching question counts: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: questionCounts.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      entry.key,
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ), 
                  ),
                  Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 8, 
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      value: entry.value / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ),
                  SizedBox(width: 8),
                  Text(
                    '${entry.value} / ${questionCounts.values.reduce((a, b) => a + b)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
