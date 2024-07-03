import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/model/request/violation_request.dart';
import 'package:eduappui/remote/model/response/violation_response.dart';
import 'package:eduappui/remote/network/network_client.dart';

class ViolationAPI {
  final NetworkClient networkClient = NetworkClient();

  Future getListViolation({Map<String, String>? sortOrders}) async {
    final response =
        await networkClient.invoke(Constants.history_violation, RequestType.get, queryParameters: sortOrders);

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
      'classId': violationRequest.classId,
      'studentInClassId': violationRequest.studentInClassId,
      'violationTypeId': violationRequest.violationTypeId,
      'teacherId': violationRequest.teacherId,
      'code': violationRequest.code,
      'violationName': violationRequest.violationName,
      'description': violationRequest.description,
      'date': violationRequest.date?.toIso8601String(),
      'images': imageFiles,
    });

    final response = await networkClient.invoke(
      Constants.create_student_violation,
      RequestType.post,
      requestBody: formData,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return 201;
    } else {
      throw ServerException.withException(
        dioError: DioException(
          response: response,
          requestOptions: response.requestOptions,
        ),
      );
    }
  }

  Future getViolationGroup({Map<String, String>? sortOrders}) async {
    final response =
        await networkClient.invoke(Constants.violation_group, RequestType.get, queryParameters: sortOrders);

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
      'code': violationRequest.code,
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
