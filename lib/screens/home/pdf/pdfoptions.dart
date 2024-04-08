import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsa_tracker_app/screens/home/pdf/pdfscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class PDFOptions extends StatefulWidget {
  const PDFOptions({Key? key}) : super(key: key);

  @override
  _PDFOptionsState createState() => _PDFOptionsState();
}

class _PDFOptionsState extends State<PDFOptions> {
  String _selectedOption = 'All';
  List<String> _questionTypes = ['All'];

  @override
  void initState() {
    super.initState();
    fetchQuestionTypes();
  }

  Future<void> fetchQuestionTypes() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('questions').get();
      List<String> types = ['All'];
      querySnapshot.docs.forEach((doc) {
        String type = doc['questionType'];
        if (!types.contains(type)) {
          types.add(type);
        }
      });
      setState(() {
        _questionTypes = types;
      });
    } catch (error) {
      print("Error fetching question types: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Options", style: GoogleFonts.manrope()),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.black
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                    });
                  },
                  items: _questionTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.manrope()),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
            onPressed: () {
                if (_selectedOption == 'All') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PDFScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PDFScreen(questionType: _selectedOption)),
                  );
                }
            },

  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 18, 7, 36),
  ),
  child: Text(
    'View Questions',
    style: GoogleFonts.manrope(
      color: Colors.white
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
