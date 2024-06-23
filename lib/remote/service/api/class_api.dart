import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/network/network_client.dart';

class ClassApi {
  final NetworkClient networkClient = NetworkClient();

  Future getListClass({Map<String, String>? sortOrders}) async {
    final response = await networkClient.invoke(Constants.class_list, RequestType.get, queryParameters: sortOrders);

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
