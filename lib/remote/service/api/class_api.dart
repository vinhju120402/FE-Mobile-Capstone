import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/network/network_client.dart';

class ClassApi {
  final NetworkClient networkClient = NetworkClient();

  Future getListClass(int schoolId, {Map<String, String>? sortOrders}) async {
    final response = await networkClient.invoke("${Constants.class_list}/school/$schoolId", RequestType.get,
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
}
