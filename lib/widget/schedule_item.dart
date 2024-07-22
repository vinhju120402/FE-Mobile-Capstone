import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final String from;
  final String to;
  final String supervisorName;
  final String className;
  final String teacherName;

  const ScheduleItem(
      {super.key,
      required this.from,
      required this.to,
      required this.supervisorName,
      required this.className,
      required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(DateTime.parse(from)),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text('đến', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text(
                    DateFormat('dd/MM/yyyy').format(DateTime.parse(to)),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
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
                  Text('Sao Đỏ: $supervisorName'),
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
      ),
    );
  }
}
