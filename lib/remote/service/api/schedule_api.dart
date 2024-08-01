import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/network/network_client.dart';

class ScheduleApi {
  final NetworkClient networkClient = NetworkClient();

  Future getDutyScheduleBySupervisorId(int id) async {
    var response = await networkClient.invoke(
      '${Constants.get_duty_schedule}/supervisor/$id',
      RequestType.get,
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
