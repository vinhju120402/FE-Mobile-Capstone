import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<String> notifications = [
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
    'THÔNG BÁO GIA HẠN NỘP HỒ SƠ NHẬP HỌC',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(226, 134, 253, 237),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Showing ${notifications.length} results',
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(188, 85, 239, 126),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notifications[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Date: 6/5/2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
