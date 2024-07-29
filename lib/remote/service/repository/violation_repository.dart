import 'package:eduappui/remote/model/request/violation_request.dart';
import 'package:eduappui/remote/model/response/violation_group_response.dart';
import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/model/response/violation_type_response.dart';
import 'package:eduappui/remote/service/api/violation_api.dart';

abstract class ViolationRepository {
  Future<List<ViolationResponse>> getListViolation(int schoolId, {String? sortOrder});
  Future<ViolationResponse> getViolationById(int id);
  Future createViolation(ViolationRequest violation);
  Future<List<ViolationGroupResponse>> getViolationGroup(int schoolId, {String? sortOrder});
  Future<List<ViolationTypeResponse>> getListViolationTypeByGroup(int groupId, {String? sortOrder});
}

class ViolationRepositoryImpl extends ViolationRepository {
  final ViolationAPI historyViolationAPI = ViolationAPI();

  @override
  Future<List<ViolationResponse>> getListViolation(int schoolId, {String? sortOrder}) async {
    List<dynamic> dynamicList =
        await historyViolationAPI.getListViolation(schoolId, sortOrders: {"sortOrder": sortOrder ?? "desc"});
    List<ViolationResponse> responseList = dynamicList.map((item) => ViolationResponse.fromJson(item)).toList();
    return responseList;
  }

  @override
  Future<ViolationResponse> getViolationById(int id) {
    return historyViolationAPI.getViolationById(id);
  }

  @override
  Future createViolation(ViolationRequest violation) {
    var response = historyViolationAPI.createViolation(violation);
    return response;
  }

  @override
  Future<List<ViolationGroupResponse>> getViolationGroup(int schoolId, {String? sortOrder}) async {
    List<dynamic> dynamicList =
        await historyViolationAPI.getViolationGroup(schoolId, sortOrders: {"sortOrder": sortOrder ?? "desc"});
    List<ViolationGroupResponse> responseList =
        dynamicList.map((item) => ViolationGroupResponse.fromJson(item)).toList();
    return responseList;
  }

  @override
  Future<List<ViolationTypeResponse>> getListViolationTypeByGroup(int groupId, {String? sortOrder}) async {
    List<dynamic> dynamicList = await historyViolationAPI
        .getViolationTypeByGroupId(query: {"vioGroupId": groupId, "sortOrder": sortOrder ?? "desc"});
    List<ViolationTypeResponse> responseList = dynamicList.map((item) => ViolationTypeResponse.fromJson(item)).toList();
    return responseList;
  }

  Future editViolation(int id, ViolationRequest violation) {
    return historyViolationAPI.editViolation(id, violation);
  }
}
