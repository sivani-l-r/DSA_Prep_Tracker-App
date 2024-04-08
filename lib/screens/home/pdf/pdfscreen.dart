import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

class PDFScreen extends StatelessWidget {
  final String? questionType;

  const PDFScreen({Key? key, this.questionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notes", style: GoogleFonts.manrope()),           
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => PdfPreview(invoice: invoice),
      //       ),
      //     );
      //   },
      //   child: Icon(Icons.picture_as_pdf),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: questionType != null
              ? FirebaseFirestore.instance
                  .collection('questions')
                  .where('questionType', isEqualTo: questionType)
                  .snapshots()
              : FirebaseFirestore.instance.collection('questions').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final questions = snapshot.data!.docs;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final questionName = question['questionName'];
                final questionType = question['questionType'];
                final timeComplexity = question['timeComplexity'];
                final spaceComplexity = question['spaceComplexity'];
                final note = question['notes'];
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Name: $questionName',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Type: $questionType'),
                        Text('Time Complexity: $timeComplexity'),
                        Text('Space Complexity: $spaceComplexity'),
                        Text('Note: $note'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pdf/widgets.dart' as pdfLib; // Import from the pdf package



// class PDFScreen extends StatelessWidget {
//   final String? questionType;

//   const PDFScreen({Key? key, this.questionType}) : super(key: key);

//   Future<void> _createPDF(BuildContext context, List<QueryDocumentSnapshot> questions) async {
//     final pdf = pdfLib.Document();

//     for (int i = 0; i < questions.length; i++) {
//       final question = questions[i];
//       final questionName = question['questionName'];
//       final questionType = question['questionType'];
//       final timeComplexity = question['timeComplexity'];
//       final spaceComplexity = question['spaceComplexity'];
//       final note = question['notes'];

//       pdf.addPage(
//         pdfLib.Page(
//           build: (context) => pdfLib.Column(
//             crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
//             children: [
//               pdfLib.Text('Question ${i + 1}', style: pdfLib.TextStyle(fontWeight: pdfLib.FontWeight.bold)),
//               pdfLib.SizedBox(height: 8),
//               pdfLib.Text('Name: $questionName', style: pdfLib.TextStyle(fontWeight: pdfLib.FontWeight.bold)),
//               pdfLib.SizedBox(height: 4),
//               pdfLib.Text('Type: $questionType'),
//               pdfLib.Text('Time Complexity: $timeComplexity'),
//               pdfLib.Text('Space Complexity: $spaceComplexity'),
//               pdfLib.Text('Note: $note'),
//             ],
//           ),
//         ),
//       );
//     }

// // Get the directory for saving the PDF
//   final Directory appDocDir = await getApplicationDocumentsDirectory();
//   final String appDocPath = appDocDir.path;

//   // Save the PDF to a file
//   final String filePath = '$appDocPath/example.pdf';
//   final File file = File(filePath);
//   await file.writeAsBytes(await pdf.save());

//   // Open the PDF file for viewing
//   // You can use a package like 'open_file' to open the PDF automatically
//   // or provide the user with an option to open the PDF manually
  
//   // Download the PDF file
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('PDF downloaded to $filePath'),
//       duration: Duration(seconds: 3),
//     ),
//   );
//     // final output = await Navigator.of(context).push(
//     //   MaterialPageRoute(
//     //     builder: (_) => PdfViewer(pdf: pdf),
//     //   ),
//     // );

//     // You can do something with the output if needed
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Notes", style: GoogleFonts.manrope()),           
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final snapshot = await (questionType != null
//               ? FirebaseFirestore.instance
//                   .collection('questions')
//                   .where('questionType', isEqualTo: questionType)
//                   .get()
//               : FirebaseFirestore.instance.collection('questions').get());

//           final questions = snapshot.docs;
//           await _createPDF(context, questions);
//         },
//         child: Icon(Icons.picture_as_pdf),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: questionType != null
//               ? FirebaseFirestore.instance
//                   .collection('questions')
//                   .where('questionType', isEqualTo: questionType)
//                   .snapshots()
//               : FirebaseFirestore.instance.collection('questions').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }
//             final questions = snapshot.data!.docs;
//             return ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 final question = questions[index];
//                 final questionName = question['questionName'];
//                 final questionType = question['questionType'];
//                 final timeComplexity = question['timeComplexity'];
//                 final spaceComplexity = question['spaceComplexity'];
//                 final note = question['notes'];
//                 return Card(
//                   elevation: 0,
//                   color: Colors.white,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Question ${index + 1}',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Name: $questionName',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 4),
//                         Text('Type: $questionType'),
//                         Text('Time Complexity: $timeComplexity'),
//                         Text('Space Complexity: $spaceComplexity'),
//                         Text('Note: $note'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
