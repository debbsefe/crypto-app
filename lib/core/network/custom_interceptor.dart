import 'package:crypto_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout) {
      throw TimeOutException();
    }
    if (err.response == null) {
      throw NetworkException();
    }

    if (err.response?.statusCode == 500) {
      throw ServerException(message: err.message);
    } else if (err.response?.statusCode == 400) {
      throw BadRequestException(message: err.message);
    } else {
      throw ServerException();
    }
  }
}
