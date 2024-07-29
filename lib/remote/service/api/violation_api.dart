import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/local/local_client.dart';
import 'package:eduappui/remote/model/request/violation_request.dart';
import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/network/network_client.dart';

class ViolationAPI {
  final NetworkClient networkClient = NetworkClient();

  Future getListViolation(int schoolId, {Map<String, String>? sortOrders}) async {
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

    if (violationRequest.images != null && violationRequest.images!.isNotEmpty) {
      imageFiles = violationRequest.images!
          .where((file) => file.path.isNotEmpty)
          .map((file) => MultipartFile.fromFileSync(file.path))
          .toList();
    }

    FormData formData = FormData.fromMap({
      'schoolId': violationRequest.schoolId,
      'year': violationRequest.schoolYear,
      'classId': violationRequest.classId,
      'studentInClassId': violationRequest.studentInClassId,
      'violationTypeId': violationRequest.violationTypeId,
      'teacherId': violationRequest.teacherId,
      'violationName': violationRequest.violationName,
      'description': violationRequest.description,
      'date': violationRequest.date?.toIso8601String(),
      'images': imageFiles,
    });
    LocalClientImpl localClientImpl = LocalClientImpl();
    bool isTeacher = await localClientImpl.readData('isAdmin');

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

  Future getViolationTypeByGroupId({Map<String, dynamic>? query}) async {
    final response = await networkClient.invoke(Constants.violation_type, RequestType.get, queryParameters: query);

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

  Future editViolation(int id, ViolationRequest violationRequest) async {
    List<MultipartFile> imageFiles = [];

    if (violationRequest.images != null && violationRequest.images!.isNotEmpty) {
      imageFiles = violationRequest.images!
          .where((file) => file.path.isNotEmpty)
          .map((file) => MultipartFile.fromFileSync(file.path))
          .toList();
    }

    FormData formData = FormData.fromMap({
      'classId': violationRequest.classId,
      'studentInClassId': violationRequest.studentInClassId,
      'violationTypeId': violationRequest.violationTypeId,
      'teacherId': violationRequest.teacherId,
      'violationName': violationRequest.violationName,
      'description': violationRequest.description,
      'date': violationRequest.date?.toIso8601String(),
      'images': imageFiles,
    });

    final response = await networkClient.invoke(
      '${Constants.edit_violation_history}?id=$id',
      RequestType.put,
      requestBody: formData,
    );

    if (response.statusCode == 200) {
      return 200;
    } else {
      throw ServerException.withException(
        dioError: DioException(
          response: response,
          requestOptions: response.requestOptions,
        ),
      );
    }
  }
}
