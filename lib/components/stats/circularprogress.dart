import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircularProgressWidget extends StatelessWidget {
  final double progress;
  final String difficulty;

  CircularProgressWidget({
    required this.progress,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(difficulty, 
          style: GoogleFonts.manrope(
              fontSize:15,
              fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 10),
          CircularProgressIndicator(
            value: progress,
            backgroundColor: Color.fromARGB(255, 192, 160, 247),
            valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 16, 44, 67)),
            strokeWidth: 8.0,
          ),
        ],
      ),
    );
  }
}
