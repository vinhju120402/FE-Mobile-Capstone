import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/model/request/login_request.dart';
import 'package:eduappui/remote/model/response/login_response.dart';
import 'package:eduappui/remote/network/network_client.dart';

class LoginAPI {
  final NetworkClient networkClient = NetworkClient();

  Future<LoginResponse> login(LoginRequest request) async {
    var response = await networkClient.invoke(
      '${Constants.login}?isAdmin=false',
      RequestType.post,
      requestBody: {"phone": request.phoneNumber, "password": request.password},
    );
    print(request.phoneNumber);
    print(request.password);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    } else {
      throw ServerException.withException(
          dioError: DioException(
        response: response,
        requestOptions: response.requestOptions,
      ));
    }
  }
}
