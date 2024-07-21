import 'package:eduappui/remote/model/response/violation_config_response.dart';
import 'package:eduappui/remote/service/repository/rule_repository.dart';
import 'package:eduappui/widget/TextField/common_text_field.dart';
import 'package:eduappui/widget/app_bar.dart';
import 'package:eduappui/widget/base_main_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RuleScreen extends StatefulWidget {
  const RuleScreen({super.key});

  @override
  State<RuleScreen> createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {
  final RuleRepositoryImpl ruleRepositoryImpl = RuleRepositoryImpl();
  List<ViolationConfigResponse> ruleResponse = [];
  bool ruleLoading = true;

  @override
  void initState() {
    super.initState();
    getRule();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getRule() async {
    var response = await ruleRepositoryImpl.getRule();
    ruleResponse = response;
    ruleLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onBack: () => context.pop(),
        title: 'Quy định',
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
                        'Showing ${ruleResponse.length} results',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                //Defined Search bar
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
                  itemCount: ruleResponse.length,
                  itemBuilder: (context, index) {
                    return Padding(
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
                                left: BorderSide(color: Colors.blue, width: 5.0),
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
                                  ruleResponse[index].violationTypeName ?? '',
                                  style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ruleResponse[index].description ?? '',
                                  style: TextStyle(color: Colors.black, fontSize: 9.0, fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Điểm Trừ: -${ruleResponse[index].minusPoints ?? ''}',
                                  style: TextStyle(color: Colors.red, fontSize: 9.0, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ruleLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
