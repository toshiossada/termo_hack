import 'dart:convert';

import '../../../../commons/adapters/http_client/http_client_adapter.dart';
import '../../infra/datasources/word_datasource_interface.dart';

//https://raw.githubusercontent.com/toshiossada/termo/main/words.json

class WordDatasource implements IWordDataSource {
  final IHttpClientAdapter _httpClient;

  WordDatasource({required IHttpClientAdapter httpClient})
      : _httpClient = httpClient;

  @override
  Future<List<String>> getWords() async {
    try {
      final response = await _httpClient.get(
          'https://raw.githubusercontent.com/toshiossada/termo/main/words.json');

      final data = await json.decode(response.data);
      final words = (data['words'] as List).map((e) => e.toString()).toList();
      return words;
    } catch (e) {
      rethrow;
    }
  }
}
