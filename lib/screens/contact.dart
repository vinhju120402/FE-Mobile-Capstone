import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onBack: () => context.pop(),
        title: 'Liên hệ trường học',
      ),
      body: const BaseMainContent(
        children: Column(
          children: [
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa nội dung
                    children: [
                      Text(
                        'Dịch vụ hỗ trợ trường học',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Divider(
                        height: 30,
                        thickness: 2,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
                        children: [
                          Icon(
                            Icons.call,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '01234567890',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '123456@gmail.com',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
