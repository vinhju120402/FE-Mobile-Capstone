import 'package:eduappui/remote/model/request/user_request.dart';
import 'package:eduappui/remote/model/response/user_response.dart';
import 'package:eduappui/remote/service/api/user_api.dart';

abstract class UserRepository {
  Future<UserResponse> getUserbyId(int id);
  Future updateUser(int id, UserResquest userRequest);
}

class UserRepositoryImpl extends UserRepository {
  final UserApi userApi = UserApi();

  @override
  Future<UserResponse> getUserbyId(int id) async {
    var response = await userApi.getUserbyId(id);
    return response;
  }

  @override
  Future updateUser(int id, UserResquest userRequest) async {
    var response = await userApi.updateUser(id, userRequest);
    return response;
  }
}
