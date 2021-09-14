import 'dart:io';

import 'package:crypto_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';

class ApiBaseHelper {
  ApiBaseHelper(this.dio);

  final Dio dio;
  Future<Response> post(
      {required String path, Map<String, dynamic>? body}) async {
    try {
      Response response;

      response = await dio.post(path, data: body);

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 500) {
        throw ServerException();
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else {
        return response;
      }
    } on DioError {
      rethrow;
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw ServerException();
    }
  }
}

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // handler.next(err);

    if (err.type == DioErrorType.connectTimeout) {
      throw ServerException();
    }

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      throw UnauthorizedException();
    } else if (err.response?.statusCode == 500) {
      throw ServerException();
    } else if (err.response?.statusCode == 400) {
      throw BadRequestException();
    } else {
      throw ServerException();
    }
  }
}
