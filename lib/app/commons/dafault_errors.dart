import 'package:dio/dio.dart';

abstract class Failure implements Exception {
  String? get message;
}

class DatasourceError extends Failure {
  @override
  final String? message;
  final HttpClientError? httpError;

  DatasourceError({
    this.message,
    this.httpError,
  });
}

class HttpClientError extends Failure implements DioError {
  final int? statusCode;
  final dynamic data;
  @override
  final String message;

  HttpClientError({
    this.data,
    required this.message,
    required this.statusCode,
    this.error,
    required this.requestOptions,
    this.response,
    this.stackTrace,
    required this.type,
  });

  @override
  dynamic error;
  @override
  RequestOptions requestOptions;
  @override
  Response? response;
  @override
  StackTrace? stackTrace;
  @override
  DioErrorType type;
}
