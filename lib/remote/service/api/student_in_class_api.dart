import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/network/network_client.dart';

class StudentInClassApi {
  final NetworkClient networkClient = NetworkClient();

  Future getListStudent({Map<String, dynamic>? query}) async {
    final response = await networkClient.invoke(Constants.student_in_class, RequestType.get, queryParameters: query);
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
}
