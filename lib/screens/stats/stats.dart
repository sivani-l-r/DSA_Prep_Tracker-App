import 'package:dsa_tracker_app/components/stats/circularprogress.dart';
import 'package:dsa_tracker_app/components/stats/questiontype.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:dsa_tracker_app/components/stats/heatmap.dart'; 

class StatsScreen extends StatefulWidget {
  StatsScreen({Key? key});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<DateTime> datesWithQuestions = [];

  @override
  void initState() {
    super.initState();
    fetchDatesWithQuestions();
  }
    double easyProgress = 0.0;
  double mediumProgress = 0.0;
  double hardProgress = 0.0;

  Future<void> fetchDatesWithQuestions() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('questions').get();
      List<DateTime> dates = [];
      int easyCount = 0;
      int mediumCount = 0;
      int hardCount = 0;

      querySnapshot.docs.forEach((doc) {
        if (doc.data().containsKey('dateAdded')) {
          String timestampString = doc['dateAdded'];
          DateTime dateAdded = DateTime.parse(timestampString);
          dates.add(dateAdded);

         
          String difficulty = doc['difficulty'];
          print("difficulty");
          if (difficulty == 'easy') {
            easyCount++;
          } else if (difficulty == 'medium') {
            mediumCount++;
          } else if (difficulty == 'hard') {
            hardCount++;
          }
        }
        print("hello");
        print(easyCount);
        print(mediumCount);
        print(hardCount);
      });

      // Calculate progress
      int totalQuestions = easyCount + mediumCount + hardCount;
      setState(() {
        datesWithQuestions = dates;
        easyProgress = easyCount / totalQuestions;
        mediumProgress = mediumCount / totalQuestions;
        hardProgress = hardCount / totalQuestions;
      });
    } catch (error) {
      print("Error fetching dates: $error");
    }
  }





  @override
  Widget build(BuildContext context) {
    final daysInMonth =
        DateTime.now().subtract(Duration(days: DateTime.now().day - 1)).subtract(Duration(days: 1)).day;
    final currentMonth = DateTime.now().month;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Stats",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 4),
              StreakHeatMap(
                datesWithQuestions: datesWithQuestions,
                daysInMonth: daysInMonth,
                currentMonth: currentMonth,
              ),
              SizedBox(height: 4),
              QuestionTypeProgress(),
              SizedBox(height: 4),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                ), 
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        CircularProgressWidget(progress: easyProgress, difficulty: 'Easy'),
                        CircularProgressWidget(progress: mediumProgress, difficulty: 'Medium'),
                        CircularProgressWidget(progress: hardProgress, difficulty: 'Hard'),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
