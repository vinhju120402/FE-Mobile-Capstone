import 'package:flutter/material.dart';

class DutyScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duty Schedule'),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
      ),
      body: Container(
        color: Color.fromARGB(226, 134, 253, 237),
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(189, 7, 206, 43),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Text(
                    '1/2/2024-7/2/2024',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ScheduleItem(
                    date: 'Thu 2\n1/2/2024',
                    time: 'Thời gian: 7h-8h',
                    name: 'Họ và Tên: Nguyễn Văn A',
                    className: 'Lớp',
                  ),
                  ScheduleItem(
                    date: 'Thu 3\n2/2/2024',
                    time: 'Thời gian: 7h-8h',
                    name: 'Họ và Tên: Nguyễn Văn A',
                    className: 'Lớp',
                  ),
                  ScheduleItem(
                    date: 'Thu 4\n3/2/2024',
                    time: 'Thời gian: 7h-8h',
                    name: 'Họ và Tên: Nguyễn Văn A',
                    className: 'Lớp',
                  ),
                  ScheduleItem(
                    date: 'Thu 5\n4/2/2024',
                    time: 'Thời gian: 7h-8h',
                    name: 'Họ và Tên: Nguyễn Văn A',
                    className: 'Lớp',
                  ),
                  ScheduleItem(
                    date: 'Thu 6\n5/2/2024',
                    time: 'Thời gian: 7h-8h',
                    name: 'Họ và Tên: Nguyễn Văn A',
                    className: 'Lớp',
                  ),
                  ScheduleItem(
                    date: 'Thu 7\n6/2/2024',
                    time: 'Thời gian: 7h-8h',
                    name: 'Họ và Tên: Nguyễn Văn A',
                    className: 'Lớp',
                  ),
                  ScheduleItem(
                    date: 'Chu Nhat\n7/2/2024',
                    time: 'Thời gian: 7h-8h',
                    name: 'Họ và Tên: Nguyễn Văn A',
                    className: 'Lớp',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String date;
  final String time;
  final String name;
  final String className;

  ScheduleItem({
    required this.date,
    required this.time,
    required this.name,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 50, // Adjust height as needed
            width: 2, // Thickness of the line
            color: Colors.grey, // Color of the line
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time),
                Text(name),
                Text(className),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
