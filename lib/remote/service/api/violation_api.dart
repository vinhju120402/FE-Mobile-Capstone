import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/model/request/violation_request.dart';
import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/network/network_client.dart';

class ViolationAPI {
  final NetworkClient networkClient = NetworkClient();

  Future getListViolationBySchoolId(int schoolId, {Map<String, String>? sortOrders}) async {
    final response = await networkClient.invoke('${Constants.history_violation}/school/$schoolId', RequestType.get,
        queryParameters: sortOrders);

    if (response.statusCode == 200) {
      if (response.data['data'] == null) {
        return [];
      } else {
        return response.data['data'];
      }
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }

  Future getListViolationByUserId(int userId, {Map<String, String>? sortOrders}) async {
    LocalClientImpl localClientImpl = LocalClientImpl();
    bool isTeacher = await localClientImpl.readData('isAdmin');
    final response = await networkClient.invoke(
        isTeacher
            ? '${Constants.history_violation}/user/$userId/supervisors'
            : '${Constants.history_violation}/user/$userId/student-supervisors',
        RequestType.get,
        queryParameters: sortOrders);

    if (response.statusCode == 200) {
      if (response.data['data'] is List) {
        return response.data['data'];
      } else {
        return [];
      }
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }

  Future<ViolationResponse> getViolationById(int id) async {
    final response = await networkClient.invoke('${Constants.history_violation}/$id', RequestType.get);

    if (response.statusCode == 200) {
      return ViolationResponse.fromJson(response.data['data']);
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }

  Future createViolation(ViolationRequest violationRequest) async {
    List<MultipartFile> imageFiles = [];
    LocalClientImpl localClientImpl = LocalClientImpl();
    bool isTeacher = await localClientImpl.readData('isAdmin');
    FormData formData;

    if (violationRequest.images != null && violationRequest.images!.isNotEmpty) {
      imageFiles = violationRequest.images!
          .where((file) => file.path.isNotEmpty)
          .map((file) => MultipartFile.fromFileSync(file.path))
          .toList();
    }
    if (isTeacher) {
      formData = FormData.fromMap({
        'SchoolId': violationRequest.schoolId,
        'UserId': violationRequest.userId,
        'Year': violationRequest.schoolYear,
        'ClassId': violationRequest.classId,
        'ViolationTypeId': violationRequest.violationTypeId,
        'StudentInClassId': violationRequest.studentInClassId,
        'ViolationName': violationRequest.violationName,
        'Description': violationRequest.description,
        'Date': violationRequest.date?.toIso8601String(),
        'Images': imageFiles,
      });
    } else {
      formData = FormData.fromMap({
        'SchoolId': violationRequest.schoolId,
        'UserId': violationRequest.userId,
        'Year': violationRequest.schoolYear,
        'ClassId': violationRequest.classId,
        'ViolationTypeId': violationRequest.violationTypeId,
        'StudentInClassId': violationRequest.studentInClassId,
        'ScheduleId': violationRequest.scheduleId,
        'ViolationName': violationRequest.violationName,
        'Description': violationRequest.description,
        'Date': violationRequest.date?.toIso8601String(),
        'Images': imageFiles,
      });
    }

    final response = await networkClient.invoke(
      isTeacher ? Constants.create_teacher_violation : Constants.create_student_violation,
      RequestType.post,
      requestBody: formData,
    );

    if (response.data['success'] == true) {
      return response.data;
    } else {
      return response.data['message'];
    }
  }

  Future getViolationGroup(int schoolId, {Map<String, String>? sortOrders}) async {
    final response = await networkClient.invoke("${Constants.violation_group}/school/$schoolId", RequestType.get,
        queryParameters: sortOrders);

    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }

  Future getViolationTypeByGroupId(int groupId, {Map<String, dynamic>? query}) async {
    LocalClientImpl localClientImpl = LocalClientImpl();
    bool isTeacher = await localClientImpl.readData('isAdmin');
    final response = await networkClient.invoke(
        isTeacher
            ? '${Constants.violation_type}/violation-group/$groupId'
            : '${Constants.violation_type}//api/violation-types/by-group-for-student-supervisor/$groupId',
        RequestType.get,
        queryParameters: query);

    if (response.statusCode == 200) {
      if (isTeacher) {
        return response.data['data'];
      } else {
        return response.data;
      }
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }

  Future editViolation(int id, ViolationRequest violationRequest) async {
    List<MultipartFile> imageFiles = [];
    LocalClientImpl localClientImpl = LocalClientImpl();
    bool isTeacher = await localClientImpl.readData('isAdmin');
    FormData formData;

    if (violationRequest.images != null && violationRequest.images!.isNotEmpty) {
      imageFiles = violationRequest.images!
          .where((file) => file.path.isNotEmpty)
          .map((file) => MultipartFile.fromFileSync(file.path))
          .toList();
    }

    if (isTeacher) {
      formData = FormData.fromMap({
        'SchoolId': violationRequest.schoolId,
        'UserId': violationRequest.userId,
        'Year': violationRequest.schoolYear,
        'ClassId': violationRequest.classId,
        'ViolationTypeId': violationRequest.violationTypeId,
        'StudentInClassId': violationRequest.studentInClassId,
        'ViolationName': violationRequest.violationName,
        'Description': violationRequest.description,
        'Date': violationRequest.date?.toIso8601String(),
        'Images': imageFiles,
      });
    } else {
      formData = FormData.fromMap({
        'SchoolId': violationRequest.schoolId,
        'UserId': violationRequest.userId,
        'Year': violationRequest.schoolYear,
        'ClassId': violationRequest.classId,
        'ViolationTypeId': violationRequest.violationTypeId,
        'StudentInClassId': violationRequest.studentInClassId,
        'ScheduleId': violationRequest.scheduleId,
        'ViolationName': violationRequest.violationName,
        'Description': violationRequest.description,
        'Date': violationRequest.date?.toIso8601String(),
        'Images': imageFiles,
      });
    }

    final response = await networkClient.invoke(
      isTeacher
          ? '${Constants.edit_violation}/supervisor?id=$id'
          : '${Constants.edit_violation}/student-supervisor?id=$id',
      RequestType.put,
      requestBody: formData,
    );

    if (response.data['success'] == true) {
      return response.data;
    } else {
      return response.data['message'];
    }
  }
}
