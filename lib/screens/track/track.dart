import 'package:dsa_tracker_app/components/track/questioncard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  TextEditingController _searchController = TextEditingController();
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Tracked Questions',
          style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('questions').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return QuestionTileCardWidget(
                questionName: data['questionName'],
                questionType: data['questionType'],
                timeComplexity: data['timeComplexity'],
                spaceComplexity: data['spaceComplexity'],
                notes: data['notes'],
                difficulty: data['difficulty'], 
                attempts: data['attempts'], 
                questionLink: data['questionLink'],
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddQuestionDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddQuestionDialog(BuildContext context) {
  String questionName = '';
  String questionType = '';
  String timeComplexity = '';
  String spaceComplexity = '';
  String notes = '';
  String difficulty = ''; 
  int attempts = 1; 
  String questionLink = ''; 

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text('Add Question'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Question Name'),
                onChanged: (value) {
                  questionName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Question Type'),
                onChanged: (value) {
                  questionType = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time Complexity'),
                onChanged: (value) {
                  timeComplexity = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Space Complexity'),
                onChanged: (value) {
                  spaceComplexity = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Notes'),
                onChanged: (value) {
                  notes = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Difficulty (easy, medium, hard)'),
                onChanged: (value) {
                  difficulty = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Attempts'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  attempts = int.tryParse(value) ?? 0;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Question Link'),
                onChanged: (value) {
                  questionLink = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the current date
                String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

                // Create a map containing the question data
                Map<String, dynamic> questionData = {
                  'questionName': questionName,
                  'questionType': questionType,
                  'timeComplexity': timeComplexity,
                  'spaceComplexity': spaceComplexity,
                  'notes': notes,
                  'difficulty': difficulty,
                  'attempts': attempts,
                  'questionLink': questionLink,
                  'dateAdded': currentDate, // Add the current date
                };

                // Store the question data in Firestore
                FirebaseFirestore.instance.collection('questions').add(questionData);

                // Update user progress


                // Close the dialog
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      );
    },
  );
}


}