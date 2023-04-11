import 'package:http/http.dart';

import '../http_client_adapter.dart';
import '../http_response.dart';

class HttpAdapter implements IHttpClientAdapter {
  final Client http;

  HttpAdapter({
    required this.http,
  });

  _buildUrl(String path, Map<String, String>? queryParameters) {
    var q = '';
    final listQueryString = <String>[];
    queryParameters?.forEach((key, value) {
      listQueryString.add('$key=$value');
    });

    return Uri.parse('$path$q');
  }

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool cached = false,
  }) async {
    var url = _buildUrl(path, queryParameters);

    final result = await http.get(url, headers: headers);
    final response = HttpResponse(
      data: result.body,
      statusCode: result.statusCode,
    );
    return response;
  }

  @override
  Future<HttpResponse> post(
    String path, {
    dynamic data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var url = _buildUrl(path, queryParameters);

    final result = await http.post(
      url,
      headers: headers,
      body: data,
    );
    final response = HttpResponse(
      data: result.body,
      statusCode: result.statusCode,
    );
    return response;
  }

  @override
  Future<HttpResponse> put(
    String path, {
    dynamic data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var url = _buildUrl(path, queryParameters);
    final result = await http.put(
      url,
      headers: headers,
      body: data,
    );
    HttpResponse response = HttpResponse(
      data: result.body,
      statusCode: result.statusCode,
    );
    return response;
  }

  @override
  Future<HttpResponse> delete(
    String path, {
    dynamic data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var url = _buildUrl(path, queryParameters);
    final result = await http.put(
      url,
      headers: headers,
      body: data,
    );

    HttpResponse response = HttpResponse(
      data: result.body,
      statusCode: result.statusCode,
    );
    return response;
  }
}
