import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/model/response/user_response.dart';
import 'package:eduappui/remote/network/network_client.dart';

class UserApi {
  final NetworkClient networkClient = NetworkClient();

  Future<UserResponse> getUserbyId(int id) async {
    var response = await networkClient.invoke(
      '${Constants.get_user}/$id',
      RequestType.get,
    );
    if (response.statusCode == 200) {
      return UserResponse.fromJson(response.data['data']);
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }
}
