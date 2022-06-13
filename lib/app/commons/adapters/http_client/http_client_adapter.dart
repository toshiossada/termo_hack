import 'http_response.dart';

abstract class IHttpClientAdapter {
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
  });

  Future<HttpResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
  });

  Future<HttpResponse> put(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
  });

  Future<HttpResponse> delete(
    String path, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
  });
}
