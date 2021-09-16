import 'package:crypto_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message});

  ///failure message
  final String? message;
  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({this.message}) : super(message: message);
  final String? message;
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({this.message}) : super(message: message);
  final String? message;
}

class NetworkFailure extends Failure {
  const NetworkFailure({this.message}) : super(message: message);
  final String? message;
}

/// Extension functions for working with [DioError]s
extension ErrorConversion on DioError {
  Failure toFailure() {
    if (this is BadRequestException) {
      return BadRequestFailure(message: message);
    } else if (this is NetworkException) {
      return NetworkFailure(message: message);
    } else if (this is ServerException) {
      return ServerFailure(message: message);
    } else {
      return const ServerFailure();
    }
  }
}
