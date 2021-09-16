import 'package:crypto_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // handler.next(err);

    if (err.type == DioErrorType.connectTimeout) {
      throw ServerException();
    }

    if (err.response?.statusCode == 500) {
      throw ServerException();
    } else if (err.response?.statusCode == 400) {
      throw BadRequestException();
    } else {
      throw ServerException();
    }
  }
}
