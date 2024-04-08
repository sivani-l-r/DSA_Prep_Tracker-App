import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dsa_tracker_app/screens/practice/practicescreen.dart';
import 'package:google_fonts/google_fonts.dart';

class PracticeTestOptions extends StatefulWidget {
  @override
  _PracticeTestOptionsState createState() => _PracticeTestOptionsState();
}

class _PracticeTestOptionsState extends State<PracticeTestOptions> {
  int _numberOfQuestions = 10; // Default value
  String _selectedQuestionType = 'Multiple Choice'; 
  int _maximumNumberOfQuestions = 0; 

    @override
  void initState() {
    super.initState();
    _fetchMaximumNumberOfQuestions();
  }

    void _fetchMaximumNumberOfQuestions() async {
    
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('questions').get();
    setState(() {
      _maximumNumberOfQuestions = snapshot.size;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Flashcard Options',
          style: GoogleFonts.manrope(),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Range of Questions:',
              textAlign: TextAlign.left,
              style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _numberOfQuestions.toDouble(),
              min: 5,
              max: 50,
              divisions: 9,
              label: _numberOfQuestions.toString(),
              onChanged: (value) {
                setState(() {
                  _numberOfQuestions = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
            onPressed: () {
              if (_numberOfQuestions >= _maximumNumberOfQuestions) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('The selected range exceeds the number of available questions.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Navigate to PracticeScreen with selected options
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PracticeScreen(
                    numberOfQuestions: _numberOfQuestions,
                    questionType: _selectedQuestionType,
                  )),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
              elevation: 4, // Elevation
              shape: RoundedRectangleBorder( // Button border
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0), // Button padding
              child: Text(
                'Generate',
                style: GoogleFonts.manrope(), // Text style
              ),
            ),
          ),

          ],
        ),
      ),
    );
  }
}
