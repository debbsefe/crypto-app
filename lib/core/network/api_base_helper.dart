import 'dart:io';

import 'package:crypto_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';

class ApiBaseHelper {
  ApiBaseHelper(Dio dio) : _dio = dio;

  final Dio _dio;

  var options = BaseOptions(
    baseUrl: ' Constants.baseUrl',
    connectTimeout: 60000,
    receiveTimeout: 60000,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  Future<Response> post(
      {required String path,
      required Map<String, dynamic> body,
      bool auth = true}) async {
    _dio.options = options;

    if (auth) {
      _dio.interceptors.add(AuthHeaderInterceptor());
    }

    try {
      Response response;

      response = await _dio.post(path, data: body);

      print(response.statusCode);

      if (response.statusCode == 403 || response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 500) {
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

class AuthHeaderInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

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
