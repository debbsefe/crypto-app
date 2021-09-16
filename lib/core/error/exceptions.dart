import 'package:dio/dio.dart';

class NetworkException extends DioError {
  final String message;
  NetworkException({this.message = 'No internet connection detected'})
      : super(requestOptions: RequestOptions(path: ''));
}

class ServerException extends DioError {
  final String message;

  ServerException({this.message = 'Something went wrong, please try again'})
      : super(requestOptions: RequestOptions(path: ''));
}

class BadRequestException extends DioError {
  final String message;
  BadRequestException({required this.message})
      : super(requestOptions: RequestOptions(path: ''));
}

class TimeOutException extends DioError {
  final String message;
  TimeOutException({this.message = 'Connection timeout'})
      : super(requestOptions: RequestOptions(path: ''));
}
