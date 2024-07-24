import 'package:dio/dio.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/errors/exceptions.dart';
import 'package:eduappui/remote/network/network_client.dart';

class SchoolYearApi {
  final NetworkClient networkClient = NetworkClient();

  Future getListSchoolYearBySchoolId(int schoolId) async {
    final response = await networkClient.invoke("${Constants.get_school_year}/school/$schoolId", RequestType.get);

    if (response.statusCode == 200) {
      if (response.data['data'] == null) {
        return [];
      } else {
        print(response.data['data']);
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
