import 'package:eduappui/remote/model/request/login_request.dart';
import 'package:eduappui/remote/model/response/login_response.dart';
import 'package:eduappui/remote/service/api/login_api.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(LoginRequest loginRequest);
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginAPI loginAPI = LoginAPI();

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    //adding try catch block to handle exceptions
    try {
      var response = await loginAPI.login(loginRequest);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
