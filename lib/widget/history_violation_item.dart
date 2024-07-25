import 'package:eduappui/remote/local/local_client.dart';
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
    bool isAdmin = false;
    LocalClientImpl localClientImpl = LocalClientImpl();
    isAdmin = localClientImpl.readData("isAdmin");
    return GestureDetector(
      onTap: ontapFunction,
      child: Padding(
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
                  left: BorderSide(color: isAdmin ? Colors.blue : Color(0xFFB74848), width: 5.0),
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
                    'Họ và Tên: $name',
                    style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Loại Vi Phạm: $violationName',
                    style: TextStyle(color: Colors.black, fontSize: 9.0, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'Date: ${DateFormat.yMd().format(DateTime.parse(date))} ',
                    style: TextStyle(color: Colors.red, fontSize: 9.0, fontStyle: FontStyle.italic),
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
