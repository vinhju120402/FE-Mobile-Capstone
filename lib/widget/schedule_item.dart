import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class ScheduleItem extends StatelessWidget {
//   final String date;
//   final String time;
//   final String name;
//   final String className;

//   const ScheduleItem({
//     super.key,
//     required this.date,
//     required this.time,
//     required this.name,
//     required this.className,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       margin: const EdgeInsets.all(8),
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               date,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Container(
//             height: 50, // Adjust height as needed
//             width: 2, // Thickness of the line
//             color: Colors.grey, // Color of the line
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(time),
//                 Text(name),
//                 Text(className),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
