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
      return response.data['data'];
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
    FormData formData = FormData.fromMap({
      'classId': violationRequest.classId,
      'studentInClassId': violationRequest.studentInClassId,
      'violationTypeId': violationRequest.violationTypeId,
      'teacherId': violationRequest.teacherId,
      'code': violationRequest.code,
      'violationName': violationRequest.violationName,
      'description': violationRequest.description,
      'date': violationRequest.date?.toIso8601String(),
      'images': violationRequest.images != null
          ? violationRequest.images!.map((file) => MultipartFile.fromFileSync(file.path)).toList()
          : [],
    });

    final response = await networkClient.invoke(
      Constants.history_violation,
      RequestType.post,
      requestBody: formData,
    );

    if (response.statusCode == 201) {
      return response.data;
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
}
