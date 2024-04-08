import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GamifiedProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('user_progress').doc('user_id').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading indicator while fetching data
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error message if there's an error fetching data
          return Text("Error: ${snapshot.error}");
        } else {
          // Extract progress data from snapshot
          int progress = snapshot.data!['progress'];

          // Determine progress status
          bool firstStepCompleted = progress >= 10;
          bool secondStepCompleted = progress >= 20;
          // Add more steps as needed...

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gamified Progress Bar",
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 30,
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildProgressIndicator(firstStepCompleted),
                        _buildProgressIndicator(secondStepCompleted),
                        // Add more progress indicators for additional steps...
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Track 10 questions",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: firstStepCompleted ? Colors.green : Colors.black,
                        ),
                      ),
                      Text(
                        "Earn Badge",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondStepCompleted ? Colors.green : Colors.black,
                        ),
                      ),
                      // Add more text labels for additional steps...
                    ],
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildProgressIndicator(bool completed) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: completed ? Colors.green : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: completed ? Icon(Icons.check, color: Colors.white) : null,
    );
  }
}
