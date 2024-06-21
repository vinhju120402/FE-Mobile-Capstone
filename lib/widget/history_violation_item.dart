import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryViolationItem extends StatelessWidget {
  const HistoryViolationItem({
    super.key,
    this.ontapFunction,
    required this.name,
    required this.violationName,
    required this.date,
  });
  final Function()? ontapFunction;
  final String name;
  final String violationName;
  final String date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapFunction,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          color: Color.fromARGB(188, 85, 239, 126),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Họ và Tên: $name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Loại Vi Phạm: $violationName',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Date: ${DateFormat.yMd().format(DateTime.parse(date))} ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
