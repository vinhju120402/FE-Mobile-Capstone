import 'package:eduappui/remote/model/response/violation_config_response.dart';
import 'package:eduappui/remote/service/api/rule_api.dart';

abstract class RuleRepository {
  Future<List<ViolationConfigResponse>> getRule();
}

class RuleRepositoryImpl implements RuleRepository {
  final RuleAPI ruleApi = RuleAPI();

  @override
  Future<List<ViolationConfigResponse>> getRule() async {
    List<dynamic> dynamicList = await ruleApi.getViolationConfig(query: {"sortOrder": "asc"});
    List<ViolationConfigResponse> responseList =
        dynamicList.map((item) => ViolationConfigResponse.fromJson(item)).toList();
    return responseList;
  }
}
