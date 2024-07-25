import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAdmin = false;
    LocalClientImpl localClientImpl = LocalClientImpl();
    isAdmin = localClientImpl.readData("isAdmin");
    return Scaffold(
      appBar: CustomAppbar(
        onBack: () => context.pop(),
        title: 'Liên hệ trường học',
      ),
      body: BaseMainContent(
        children: Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa nội dung
                    children: [
                      const Text(
                        'Dịch vụ hỗ trợ trường học',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const Divider(
                        height: 30,
                        thickness: 2,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
                        children: [
                          Icon(
                            Icons.call,
                            color: isAdmin ? Colors.blue : const Color(0xFFB74848),
                          ),
                          const SizedBox(width: 8.0),
                          const Text(
                            '01234567890',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
                        children: [
                          Icon(
                            Icons.email,
                            color: isAdmin ? Colors.blue : Color(0xFFB74848),
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
