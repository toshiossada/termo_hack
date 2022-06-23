import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/http_client/http_client_adapter.dart';
import 'package:termo/app/commons/adapters/http_client/http_response.dart';
import 'package:termo/app/commons/dafault_errors.dart';
import 'package:termo/app/modules/words/data/external/datasources/word_datasource.dart';

import 'word_datasource_test.mocks.dart';

@GenerateMocks([IHttpClientAdapter])
void main() {
  late final WordDatasource wordDatasouce;
  final httpClient = MockIHttpClientAdapter();

  setUpAll(() {
    wordDatasouce = WordDatasource(httpClient: httpClient);
  });

  test('''
Dado a requisiçao das palavras na API
Quando a API retornar lista de palavras
Então deve acessar lista de palavras na chave word e retornar lista
''', () async {
    final words = [
      'Aarão',
      'Abel',
      'Abner',
      'Acab',
      'Acaia',
    ];
    var response =
        HttpResponse(statusCode: 200, data: json.encode({'words': words}));

    when(httpClient.get(any)).thenAnswer((_) async => response);

    var result = await wordDatasouce.getWords();

    expect(result.length, words.length);
  });
  test('''
Dado a requisiçao das palavras na API
Quando a API retornar um Map vazio
Então deve lançar um DatasourceError
''', () async {
    var response = HttpResponse(statusCode: 200, data: {});

    when(httpClient.get(any)).thenAnswer((_) async => response);

    var result = wordDatasouce.getWords();

    expect(result, throwsA(isA<DatasourceError>()));
  });

  test('''
Dado a requisiçao das palavras na API
Quando a API retornar null
Então deve lançar um DatasourceError
''', () async {
    var response = HttpResponse(statusCode: 200, data: null);

    when(httpClient.get(any)).thenAnswer((_) async => response);

    var result = wordDatasouce.getWords();

    expect(result, throwsA(isA<DatasourceError>()));
  });

  test('''
Dado a requisiçao das palavras na API
Quando a requisiçao da API der erro
Então deve lançar um DatasourceError
''', () async {
    when(httpClient.get(any)).thenThrow(HttpClientError(
      data: {},
      statusCode: 500,
      type: DioErrorType.response,
      message: '',
      requestOptions: RequestOptions(path: ''),
    ));
    DatasourceError? error;
    try {
      await wordDatasouce.getWords();
    } on DatasourceError catch (e) {
      error = e;
    }

    expect(error?.httpError != null, true);
  });
}
