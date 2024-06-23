import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
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
}
