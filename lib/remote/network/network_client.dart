import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eduappui/remote/errors/exceptions.dart';

class NetworkClient {
  final Dio dio = Dio();

  Future<Response> invoke(String url, RequestType requestType,
      {Map<String, dynamic>? queryParameters, dynamic requestBody}) async {
    // String accessToken = await secureStorageImpl.getAccessToken() ?? '';
    Response response;
    Map<String, String>? headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $accessToken',
    };
    try {
      switch (requestType) {
        case RequestType.get:
          response = await dio.get(url,
              queryParameters: queryParameters, options: Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.post:
          response = await dio.post(url,
              queryParameters: queryParameters,
              data: requestBody,
              options: Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.put:
          response = await dio.put(url,
              queryParameters: queryParameters,
              data: requestBody,
              options: Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.delete:
          response = await dio.delete(url,
              queryParameters: queryParameters,
              data: requestBody,
              options: Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.patch:
          response = await dio.patch(url,
              queryParameters: queryParameters,
              data: requestBody,
              options: Options(responseType: ResponseType.json, headers: headers));
          break;
      }
      return response;
    } on DioException catch (dioError) {
      throw ServerException(dioError: dioError);
    } on SocketException {
      rethrow;
    }
  }
}

enum RequestType { get, post, put, delete, patch }
