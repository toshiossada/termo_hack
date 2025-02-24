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

class HttpClientError extends Failure implements DioException {
  final int? statusCode;
  final dynamic data;
  @override
  final String message;

  HttpClientError({
    this.data,
    required this.message,
    required this.statusCode,
    required this.requestOptions,
    this.response,
    this.type = DioExceptionType.unknown,
    this.error,
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.current;

  @override
  dynamic error;
  @override
  RequestOptions requestOptions;
  @override
  Response? response;
  @override
  StackTrace stackTrace;
  @override
  DioExceptionType type;

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
      Response? response,
      DioExceptionType? type,
      Object? error,
      StackTrace? stackTrace,
      String? message}) {
    return HttpClientError(
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      message: message ?? this.message,
      statusCode: statusCode,
      data: data,
    );
  }

  @override
  DioExceptionReadableStringBuilder? stringBuilder;
}
