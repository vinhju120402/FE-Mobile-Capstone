import 'package:eduappui/remote/model/response/schedule_response.dart';
import 'package:eduappui/remote/service/repository/schedule_repository.dart';
import 'package:eduappui/widget/Select_Dropdown/multiselect_dropdown.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:eduappui/widget/schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DutyScheduleScreen extends StatefulWidget {
  const DutyScheduleScreen({super.key});

  @override
  State<DutyScheduleScreen> createState() => _DutyScheduleScreenState();
}

class _DutyScheduleScreenState extends State<DutyScheduleScreen> {
  ScheduleRepositoryImpl scheduleRepository = ScheduleRepositoryImpl();
  List<ScheduleResponse> scheduleList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getSchedule();
  }

  void getSchedule() async {
    var schedule = await scheduleRepository.getDutySchedule();
    scheduleList = schedule;
    isLoading = false;
    setState(() {});
  }

  void filterSchedule(String status) async {
    var schedule = await scheduleRepository.getDutySchedule();
    scheduleList = schedule.where((element) => element.status == status).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onBack: () => context.pop(),
        title: 'Lịch trực',
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Color(0xFFB74848),
            ))
          : BaseMainContent(
              children: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: MultiSelectDropDown<int>(
                      onOptionSelected: (List<ValueItem> selectedOptions) {
                        if (selectedOptions.isNotEmpty) {
                          filterSchedule(selectedOptions[0].label);
                        }
                      },
                      options: const [
                        ValueItem(label: 'FINISHED', value: null),
                        ValueItem(label: 'ONGOING', value: null),
                      ],
                      selectionType: SelectionType.single,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight: 300,
                      optionTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
                      selectedOptionIcon: const Icon(
                        Icons.check_circle,
                        color: Color(0xFFB74848),
                      ),
                      clearIcon: const Icon(
                        Icons.clear,
                      ),
                      clearAction: () {
                        filterSchedule('');
                      },
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: scheduleList.length,
                    itemBuilder: (context, index) {
                      return ScheduleItem(
                        className: scheduleList[index].classId.toString(),
                        supervisorName: scheduleList[index].supervisorName ?? '',
                        from: scheduleList[index].from.toString(),
                        to: scheduleList[index].to.toString(),
                        teacherName: scheduleList[index].teacherName ?? '',
                        status: scheduleList[index].status ?? '',
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
