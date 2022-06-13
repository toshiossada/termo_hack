import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../dafault_errors.dart';

class CustomInterceptors extends InterceptorsWrapper {
  CustomInterceptors();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //Imprimindo informações do request para debug
    if (kDebugMode) {
      log(json.encode('BaseURL: ${options.baseUrl}'), name: 'Request[BaseURL]');
      log(json.encode('Endpoint: ${options.path}'), name: 'Request[Endpoint]');
      if (options.headers['access-token'] != null) {
        log(json.encode('access-token: ${options.headers['access-token']}'),
            name: 'Request[access-token]');
      }
      if (options.data != null) {
        log(json.encode('Payload: ${json.encode(options.data)}'),
            name: 'Request[Payload]');
      }
    }
    print('i');
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      {
        log(json.encode('Response: ${response.data}'), name: 'Response');
      }
      handler.next(response);
    }
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    print('r');
    HttpClientError failure;
    if (err.response?.statusCode == 401) {
      failure = HttpClientError(
          message: 'Falha ao realizar login.',
          requestOptions: err.requestOptions,
          statusCode: err.response?.statusCode,
          stackTrace: err.stackTrace,
          type: err.type,
          data: err.requestOptions.data,
          error: err,
          response: err.response);
    } else {
      failure = HttpClientError(
          requestOptions: err.requestOptions,
          statusCode: err.response?.statusCode,
          stackTrace: err.stackTrace,
          type: err.type,
          data: err.requestOptions.data,
          error: err,
          response: err.response,
          message: 'Ocorreu um erro na requisição com o servidor');
    }

    handler.next(failure);
  }
}
