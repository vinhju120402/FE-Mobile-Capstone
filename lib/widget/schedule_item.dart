import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final String date;
  final String time;
  final String supervisorName;
  final String className;
  final String teacherName;

  const ScheduleItem(
      {super.key,
      required this.date,
      required this.time,
      required this.supervisorName,
      required this.className,
      required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
        color: Color.fromARGB(226, 134, 253, 237),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                DateFormat.yMMMEd().format(DateTime.parse(date)),
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 130,
            width: 1,
            color: Colors.black,
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Thời gian: ${DateFormat.yMMMEd().format(DateTime.parse(date))}'),
                SizedBox(height: 10),
                Text('Họ và Tên: $supervisorName'),
                SizedBox(height: 10),
                Text('Lớp: $className'),
                SizedBox(height: 10),
                Text('Giám Thị: $teacherName'),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
