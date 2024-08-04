import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final String from;
  final String to;
  final String className;
  final String teacherName;
  final String status;

  const ScheduleItem(
      {super.key,
      required this.from,
      required this.to,
      required this.className,
      required this.teacherName,
      required this.status});

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
                  Row(
                    children: [
                      Text(
                        'Lớp: ',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(className, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Giám Thị: ',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(teacherName, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Trạng Thái: ',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          color: status == 'FINISHED' ? Colors.green : Colors.amber,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
