import 'package:eduappui/remote/model/response/schedule_response.dart';
import 'package:eduappui/remote/service/repository/schedule_repository.dart';
import 'package:eduappui/widget/schedule_item.dart';
import 'package:flutter/material.dart';

class DutyScheduleScreen extends StatefulWidget {
  const DutyScheduleScreen({super.key});

  @override
  State<DutyScheduleScreen> createState() => _DutyScheduleScreenState();
}

class _DutyScheduleScreenState extends State<DutyScheduleScreen> {
  ScheduleRepositoryImpl scheduleRepository = ScheduleRepositoryImpl();
  List<ScheduleResponse> scheduleList = [];
  @override
  void initState() {
    super.initState();
    getSchedule();
  }

  getSchedule() async {
    var schedule = await scheduleRepository.getDutySchedule();
    scheduleList = schedule;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch trực'),
        backgroundColor: const Color.fromARGB(189, 7, 206, 43),
      ),
      body: Container(
        color: const Color.fromARGB(226, 134, 253, 237),
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(189, 7, 206, 43),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Row(
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
              child: ListView.builder(
                itemCount: scheduleList.length,
                itemBuilder: (context, index) {
                  return ScheduleItem(
                    className: scheduleList[index].classId.toString(),
                    supervisorName: scheduleList[index].supervisorName ?? '',
                    date: scheduleList[index].from.toString(),
                    time: scheduleList[index].to.toString(),
                    teacherName: scheduleList[index].teacherName ?? '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
