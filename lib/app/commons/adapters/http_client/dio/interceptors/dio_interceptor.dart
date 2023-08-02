import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../dafault_errors.dart';
import '../../../../domain/usecases/check_internet.dart';
import '../../../cache_adapter/cache_adapter.dart';
import '../../../cache_adapter/models/cache_model.dart';

class CustomInterceptorsAdapter extends InterceptorsWrapper {
  final durationCacheInMinutes = 5;
  final ICacheAdapter cacheAdapter;
  final CheckInternetUsecase checkInternetUsecase;

  CustomInterceptorsAdapter({
    required this.cacheAdapter,
    required this.checkInternetUsecase,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //Imprimindo informações do request para debug
    if (kDebugMode) {
      log(json.encode('BaseURL: ${options.baseUrl}'), name: 'Request[BaseURL]');
      log(json.encode('Endpoint: ${options.path}'), name: 'Request[Endpoint]');
      if (options.headers['access-token'] != null) {
        log(
          json.encode('access-token: ${options.headers['access-token']}'),
          name: 'Request[access-token]',
        );
      }
      if (options.data != null) {
        log(
          json.encode('Payload: ${json.encode(options.data)}'),
          name: 'Request[Payload]',
        );
      }
    }

    final online = await checkInternetUsecase();
    if ((options.extra['cached'] ?? false) || !online) {
      final id = '${options.method}${options.path}';
      var dataCached = await cacheAdapter.get(id);

      // Se não passou de 5 minutos, retorna o cache
      if (dataCached?.date != null &&
          (!online ||
              DateTime.now().difference(dataCached!.date).inMinutes <=
                  durationCacheInMinutes)) {
        handler.resolve(
          Response(
            data: json.encode(dataCached?.data),
            //     json.encode({
            //   'words': ['Aarão', 'Abel']
            // }),
            extra: options.extra,
            statusCode: 200,
            requestOptions: options,
          ),
          true,
        );

        return;
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      log(json.encode('Response: ${response.data}'), name: 'Response');
    }

    if (response.requestOptions.method == 'GET') {
      final id =
          '${response.requestOptions.method}${response.requestOptions.path}';
      var dataCached = await cacheAdapter.get(id);

      // Se passou de 5 minutos, atualiza o cache
      if (dataCached?.date == null ||
          DateTime.now()
                  .difference(dataCached?.date ?? DateTime.now())
                  .inMinutes >
              durationCacheInMinutes) {
        final data = CacheModel(
          data: json.decode(response.data),
          date: DateTime.now(),
          id: id,
        );
        cacheAdapter.put(data);
      }
    }

    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
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
        response: err.response,
      );
    } else {
      failure = HttpClientError(
        requestOptions: err.requestOptions,
        statusCode: err.response?.statusCode,
        stackTrace: err.stackTrace,
        type: err.type,
        data: err.requestOptions.data,
        error: err,
        response: err.response,
        message: 'Ocorreu um erro na requisição com o servidor',
      );
    }

    handler.next(failure);
  }
}
