import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/service/repository/violation_repository.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/widget/TextField/common_text_field.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:eduappui/widget/history_violation_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final historyViolationRepositoryImpl = ViolationRepositoryImpl();

  int numberResult = 0;
  bool historyViolationLoading = true;
  List<ViolationResponse> historyViolationResponse = [];
  bool isAdmin = false;
  LocalClientImpl localClientImpl = LocalClientImpl();

  @override
  void initState() {
    super.initState();
    isAdmin = localClientImpl.readData("isAdmin");
    getHistoryViolation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getHistoryViolation() async {
    int schoolId = int.parse(await localClientImpl.readData(Constants.school_id));
    var response = await historyViolationRepositoryImpl.getListViolation(schoolId);
    historyViolationResponse = response;

    historyViolationResponse.sort((a, b) => b.violationId!.compareTo(a.violationId!));

    numberResult = historyViolationResponse.length;
    historyViolationLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onBack: () => context.pop(),
        title: 'Lịch sử vi phạm',
      ),
      body: Stack(
        children: [
          BaseMainContent(
            children: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Hiển thị $numberResult Kết quả',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CommonTextField(
                    border: 20.0,
                    hintText: 'Tìm kiếm',
                    onChanged: (value) {},
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: historyViolationResponse.length,
                  itemBuilder: (context, index) {
                    return HistoryViolationItem(
                      date: historyViolationResponse[index].date ?? '',
                      name: historyViolationResponse[index].studentName ?? '',
                      violationName: historyViolationResponse[index].violationName ?? '',
                      ontapFunction: () {
                        context.push(ScreenRoute.violationEditScreen, extra: {
                          'id': historyViolationResponse[index].violationId,
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          historyViolationLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: isAdmin ? Colors.blue : Color(0xFFB74848),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
