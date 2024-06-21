import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/service/api/violation_api.dart';

abstract class VaiolationRepository {
  Future<List<ViolationResponse>> getViolation();
}

class ViolationRepositoryImpl extends VaiolationRepository {
  final ViolationAPI historyViolationAPI = ViolationAPI();

  @override
  Future<List<ViolationResponse>> getViolation({String? sortOrder}) async {
    List<dynamic> dynamicList = await historyViolationAPI.getViolation(sortOrders: {"sortOrder": sortOrder ?? "desc"});
    List<ViolationResponse> responseList = dynamicList.map((item) => ViolationResponse.fromJson(item)).toList();
    return responseList;
  }
}
