import 'dart:io';

import 'package:dsa_tracker_app/screens/home/pdf/pdfoptions.dart';
import 'package:dsa_tracker_app/screens/home/pdf/pdfscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsa_tracker_app/screens/practice/practicetestoptions.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _totalQuestions = 0;
  List<int> _milestones = []; 

Future<void> requestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}

  Future<void> pdfExample() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );
  await requestPermission();
  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}
    
    // Future<void> _exportNotes() async {
    // // Add header to the PDF
    // pdf.addPage(
    //   pdfLib.MultiPage(
    //     build: (pdfLib.Context context) => [
    //       pdfLib.Header(
    //         level: 0,
    //         child: pdfLib.Text("Tracked Questions"),
    //       ),
    //       pdfLib.Table.fromTextArray(context: context, data: [
    //         ["#", "Question", "Type", "Time Complexity", "Space Complexity"],
    //         // Add questions data here
    //         for (int i = 0; i < _totalQuestions; i++)
    //           [i + 1, "Question ${i + 1}", "Type", "Time", "Space"],
    //       ]),
    //     ],
    //   ),
    // );

  //   // Get external storage directory
  //   final Directory? directory = await getExternalStorageDirectory();
  //   final String filePath = '${directory?.path}/tracked_questions.pdf';
    
  //   // Save the PDF file
  //   final File file = File(filePath);
  //   await file.writeAsBytes(await pdf.save());

  //   // Show a message to the user
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('PDF exported successfully'),
  //       action: SnackBarAction(
  //         label: 'Open',
  //         onPressed: () {
  //           // Open the PDF file
  //           Process.run('open', [filePath]);
  //         },
  //       ),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Home",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 161, 161),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(16),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('questions')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              "Loading...",
                              textAlign: TextAlign.center,
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              "Error: ${snapshot.error}",
                              textAlign: TextAlign.center,
                            );
                          } else {
                            _totalQuestions = snapshot.data!.docs.length;
                            return Row(
                              children: [
                                Text(
                                  "$_totalQuestions",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                  width: 4,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Questions",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Tracked",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 116, 116),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(16),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('questions')
                            .orderBy('dateAdded')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            int streak = 3;
                            final docs = snapshot.data!.docs;
                            for (int i = 1; i < docs.length; i++) {
                              final currentTimestamp = DateTime.parse(
                                  docs[i]['dateAdded']);
                              final prevTimestamp = DateTime.parse(
                                  docs[i - 1]['dateAdded']);
                              final difference = currentTimestamp
                                  .difference(prevTimestamp)
                                  .inDays;
                              if (difference == 1) {
                                streak++;
                              } else {
                                streak = 3; 
                              }
                            }
                            int milestoneValue = (_totalQuestions ~/ 10) * 10;
                            if (_totalQuestions > 0 &&
                                !_milestones.contains(milestoneValue)) {
                              _milestones.add(milestoneValue);
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "$streak",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Continuous",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Progress",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Test the time and space complexity of all questions tracked using flashcards! ',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 253, 197, 216)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PracticeTestOptions()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              Icon(Icons.quiz),
                              SizedBox(width: 4,),
                              Text(
                                "Practice",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.manrope(
                                  fontSize: 20
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Milestones Reached",
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.local_fire_department_outlined, color: Colors.red,),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Complete 50 questions",
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 5),
                      Column(
                        children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            Icon(Icons.circle, color: Colors.grey),
                            Icon(Icons.circle, color: Colors.grey),
                            Icon(Icons.circle, color: Colors.grey),
                            Icon(Icons.circle, color: Colors.grey),

                            // // Display 5 empty circles or tick icons in the first row
                            // for (int i = 1; i <= 5; i++)
                            //   Icon(
                            //     _totalQuestions >= i * 10 ? Icons.check_circle : Icons.circle,
                            //     color: _totalQuestions >= i * 10 ? Colors.green : Colors.grey,
                            //     size: 50,
                            //   ),
                          ],
                        ),

                          SizedBox(height: 8),
                        ],
                      ),
                    
                    
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 54, 88),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Notes",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    ),
                    IconButton(
                      onPressed: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PDFOptions()),
                );
                    },
                // onPressed: pdfExample,
                     icon: Icon(Icons.description, color: Colors.white))
                ],
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
