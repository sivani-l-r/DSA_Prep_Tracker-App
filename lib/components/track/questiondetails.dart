import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedQuestionCard extends StatefulWidget {
  final String questionName;
  final String questionType;
  final String timeComplexity;
  final String spaceComplexity;
  final String notes;
  final String difficulty;
  final int attempts;
  final String questionLink;

  DetailedQuestionCard({
    required this.questionName,
    required this.questionType,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.notes,
    required this.difficulty,
    required this.attempts, 
    required this.questionLink,
  });

  @override
  State<DetailedQuestionCard> createState() => _DetailedQuestionCardState();
}

class _DetailedQuestionCardState extends State<DetailedQuestionCard> {

    Color difficultyContainerColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _setDifficultyContainerColor();
  }

  void _setDifficultyContainerColor() {
    setState(() {
      if (widget.difficulty == 'hard') {
        difficultyContainerColor = Colors.red;
      } else if (widget.difficulty == 'medium') {
        difficultyContainerColor = Colors.yellow;
      } else {
        difficultyContainerColor = Colors.green;
      }
    });
  }



Future<void> _launchUrl(String _url) async {
  final Uri _urlLink = Uri.parse(_url);
  if (!await launchUrl(_urlLink)) {
    throw Exception('Could not launch $_url');
  }
}

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.edit),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Question Details',
          style: GoogleFonts.manrope(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      widget.questionName,
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                     maxLines: 3,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => _launchUrl(widget.questionLink),
                  icon: Icon(Icons.open_in_new))
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2), 
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              'Type:',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              widget.questionType,
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              'Time Complexity:',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              widget.timeComplexity,
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              'Space Complexity:',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              widget.spaceComplexity,
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              'Difficulty:',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: difficultyContainerColor,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(
                                child: Text(
                                  widget.difficulty,
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              'Attempts:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              widget.attempts.toString(),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(77, 11, 19, 72),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Notes",
                      style: GoogleFonts.manrope(
                        fontWeight:FontWeight.bold,
                        fontSize: 20
                      ),
                      ),
                      Text(
                        widget.notes,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
