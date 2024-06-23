import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/service/api/violation_api.dart';

abstract class VaiolationRepository {
  Future<List<ViolationResponse>> getListViolation();
  Future<ViolationResponse> getViolationById(int id);
}

class ViolationRepositoryImpl extends VaiolationRepository {
  final ViolationAPI historyViolationAPI = ViolationAPI();

  @override
  Future<List<ViolationResponse>> getListViolation({String? sortOrder}) async {
    List<dynamic> dynamicList =
        await historyViolationAPI.getListViolation(sortOrders: {"sortOrder": sortOrder ?? "desc"});
    List<ViolationResponse> responseList = dynamicList.map((item) => ViolationResponse.fromJson(item)).toList();
    return responseList;
  }

  @override
  Future<ViolationResponse> getViolationById(int id) {
    return historyViolationAPI.getViolationById(id);
  }
}
