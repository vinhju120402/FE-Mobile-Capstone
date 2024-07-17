import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/network/network_client.dart';

class RuleAPI {
  final NetworkClient networkClient = NetworkClient();

  Future getViolationConfig({Map<String, dynamic>? query}) async {
    var response = await networkClient.invoke(
      Constants.get_violation_config,
      RequestType.get,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return [];
        } else {
          return response.data['data'];
        }
      }
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }
}
