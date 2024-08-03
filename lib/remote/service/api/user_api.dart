import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/model/request/user_request.dart';
import 'package:eduappui/remote/model/response/user_response.dart';
import 'package:eduappui/remote/network/network_client.dart';

class UserApi {
  final NetworkClient networkClient = NetworkClient();

  Future<UserResponse> getUserbyId(int id) async {
    var response = await networkClient.invoke(
      '${Constants.user}/$id',
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

  Future updateUser(int id, UserResquest userRequest) async {
    Map<String, dynamic> data = {
      'name': userRequest.name,
      'address': userRequest.address,
      'phone': userRequest.phone,
      'schoolId': userRequest.schoolId,
      'code': userRequest.code,
      'password': userRequest.password,
    };
    var response = await networkClient.invoke(
      '${Constants.user}/$id',
      RequestType.put,
      requestBody: data,
    );
    if (response.statusCode == 200) {
      return 200;
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }
}
