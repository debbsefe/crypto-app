import 'package:dio/dio.dart';

class NetworkException extends DioError {
  NetworkException() : super(requestOptions: RequestOptions(path: ''));
}

class CacheException extends DioError {
  CacheException() : super(requestOptions: RequestOptions(path: ''));
}

class ServerException extends DioError {
  final String message;

  ServerException({this.message = 'Something went wrong, please try again'})
      : super(requestOptions: RequestOptions(path: ''));
}

class BadRequestException extends DioError {
  BadRequestException() : super(requestOptions: RequestOptions(path: ''));
}

class UnauthorizedException extends DioError {
  UnauthorizedException() : super(requestOptions: RequestOptions(path: ''));
}
