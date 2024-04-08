import 'package:dsa_tracker_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Timer

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DashBoardScreen()),
        (route) => false, // Remove all routes from the navigation stack
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations on completing!',
              style: GoogleFonts.manrope(
                fontSize: 24,
                ),
                textAlign: TextAlign.center,
            ),
            Lottie.asset(
                'assets/congratulation.json'),
            SizedBox(height: 20), // Add a loading indicator if needed
          ],
        ),
      ),
    );
  }
}
