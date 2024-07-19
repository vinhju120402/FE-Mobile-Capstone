import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onBack: () => context.pop(),
        title: 'FAQ',
      ),
      body: BaseMainContent(
        children: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white, // Set card color
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                title: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  tileColor: Colors.white,
                  title: Text(
                    questions[index],
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
