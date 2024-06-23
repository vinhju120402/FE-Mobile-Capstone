import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/service/repository/violation_repository.dart';
import 'package:eduappui/routers/screen_route.dart';
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
  List<ViolationResponse> historyViolationResponse = [];

  @override
  void initState() {
    super.initState();
    getHistoryViolation();
  }

  void getHistoryViolation() async {
    var response = await historyViolationRepositoryImpl.getListViolation();
    historyViolationResponse = response;
    numberResult = historyViolationResponse.length;
    historyViolationResponse = response;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(226, 134, 253, 237),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'History Violation',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Showing $numberResult results',
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: historyViolationResponse.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
