import 'package:dsa_tracker_app/screens/dashboard.dart';
import 'package:dsa_tracker_app/screens/home/home.dart';
import 'package:dsa_tracker_app/screens/practice/success.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class PracticeScreen extends StatefulWidget {
  final int numberOfQuestions;
  final String questionType;

  PracticeScreen({
    required this.numberOfQuestions,
    required this.questionType,
  });

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}



class _PracticeScreenState extends State<PracticeScreen> {
  late List<QueryDocumentSnapshot> _questions;
  int _currentIndex = 0;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _fetchQuestions(); // Fetch questions when the screen initializes
  }

    void _fetchQuestions() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('questions').get();
    setState(() {
      _questions = querySnapshot.docs; // Set the list of questions
      _questions.shuffle(); // Shuffle the list of questions
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Flashcards', 
          style: GoogleFonts.manrope(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(10),
              value: (_currentIndex + 1) / widget.numberOfQuestions,
              color: Colors.green, 
              backgroundColor: const Color.fromARGB(255, 241, 220, 220), // Customize the background color as needed
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showAnswer = !_showAnswer;
                });
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        _showAnswer
                            ? 
                            'Time Complexity: ${_questions[_currentIndex]['timeComplexity']}\n'
                            'Space Complexity: ${_questions[_currentIndex]['spaceComplexity']}'
                            : _questions[_currentIndex]['questionName'],
                        style: GoogleFonts.manrope(
                          fontSize: 30,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            onPressed: _previousQuestion,
                            icon: Icon(Icons.arrow_back),
                            label: Text(
                              'Previous', 
                              style: GoogleFonts.manrope(
                                fontSize: 10
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), 
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: _nextQuestion,
                            icon: Icon(Icons.arrow_forward),
                            label: Text(
                              'Next', 
                              style: GoogleFonts.manrope(
                                fontSize: 10
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), 
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.numberOfQuestions;
      _showAnswer = false;
      if (_currentIndex == widget.numberOfQuestions - 1) {
         Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuccessScreen()),
                );
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + widget.numberOfQuestions) % widget.numberOfQuestions;
      _showAnswer = false;
    });
  }
}
