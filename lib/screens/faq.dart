import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  final List<String> questions = [
    'Do I have to buy the Mobile App?',
    'How do I get the Mobile App for my phone?',
    'What features does the Mobile App have?',
    'Is the Mobile App secure?',
    'How current is the account information ...',
    'How do I find your offices and payment\nlocations?',
  ];

  final List<String> answers = [
    'No. Our Mobile App is completely\nfree to download and install.',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Faq?')),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(226, 134, 253, 237),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(226, 134, 253, 237), // Set card color
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                backgroundColor: Color.fromARGB(188, 85, 239, 126),
                collapsedBackgroundColor: Color.fromARGB(188, 85, 239, 126),
                title: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  tileColor:
                      Color.fromARGB(188, 85, 239, 126), // Set tile color
                  title: Text(
                    questions[index],
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      answers[index],
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
