import 'package:eduappui/widget/TextField/common_text_field.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {'date': '20/07/2024', 'message': 'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC'},
    {'date': '19/07/2024', 'message': 'THÔNG BÁO VỀ VIỆC HOÀN THÀNH HỒ SƠ NHẬP HỌC'},
    {'date': '18/07/2024', 'message': 'THÔNG BÁO LỊCH HỌC KỲ MỚI'},
    {'date': '17/07/2024', 'message': 'THÔNG BÁO VỀ VIỆC ĐĂNG KÝ KHÓA HỌC MỚI'},
    {'date': '16/07/2024', 'message': 'THÔNG BÁO VỀ VIỆC NGHỈ HỌC DO BÃO'},
    {'date': '15/07/2024', 'message': 'THÔNG BÁO VỀ VIỆC ĐÓNG HỌC PHÍ'},
    {'date': '14/07/2024', 'message': 'THÔNG BÁO LỊCH THI CUỐI KỲ'},
    {'date': '13/07/2024', 'message': 'THÔNG BÁO VỀ VIỆC TỔ CHỨC HỌP PHỤ HUYNH'}
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Notifications',
        onBack: () => context.pop(),
      ),
      body: BaseMainContent(
        children: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Text(
                    'Hiển thị ${notifications.length} Kết quả',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CommonTextField(
                border: 20.0,
                hintText: 'Tìm kiếm thông báo',
                onChanged: (value) {},
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 18,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                            left: BorderSide(color: Colors.blue, width: 5.0),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33716464),
                              blurRadius: 8,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notifications[index]['Nội Dung']!,
                              style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              notifications[index]['Ngày']!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
